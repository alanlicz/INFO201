lintr::lint("app_server.R")
library("dplyr")
library(plotly)
# Read in data
source("main.R")
library(shiny)
library(ggplot2)

# Define a shiny server
server <- function(input, output) {

  # Page 1 renders scatter plot which displays EV list price vs range
  output$first_scatter <- renderPlotly({
    plot_data <- range_vs_price %>%
      filter(
        RANGE.Miles. > input$range_choice[1],
        RANGE.Miles. < input$range_choice[2]
      )

    range_vs_price_chart <- plot_ly(
      data = plot_data,
      x = ~RANGE.Miles.,
      y = ~LIST.PRICE,
      type = "scatter",
      mode = "markers",
      alpha = 1,
      hovertemplate = paste(
        "%{yaxis.title.text}: %{y}<br>",
        "%{xaxis.title.text}: %{x:.0}<br>"
      )
    ) %>%
      layout(
        xaxis = list(title = "Range in Miles"),
        yaxis = list(title = "Price")
      )
    return(range_vs_price_chart)
  })

  # Page 2 Renders a plotly object that returns the plot
  output$bar <- renderPlotly({
    return(build_bar_chart(ev_sales, input$plotvar))
  })

  # Page 3 Renders a plotly object that returns the bar chart
  output$bar_range <- renderPlotly({
    return(get_range_plot(input$series))
  })
}
