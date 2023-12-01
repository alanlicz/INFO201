library(shiny)
source("main.R")
library(shinyjs)
library(knitr)
library(plotly)

server <- function(input, output) {
  #when switch the tab and reset the control panel.
  tabSwitch <- function(tab) {
     if(tab == "Individual State Population Breakdown") {
      shinyjs::show("state")
      shinyjs::show("category")
      shinyjs::hide("top")
      shinyjs::hide("series")
      shinyjs::hide("county")
    }else {
      shinyjs::hide("state")
      shinyjs::hide("category")
      shinyjs::show("series")
      shinyjs::show("top")
      shinyjs::hide("county")
    }
  }
  
  output$state <- renderPlot({
    tabSwitch(input$mainPanel)
    getPlot(input$category ,input$state)
  })
  
  output$rank.table<- renderDataTable({
    tabSwitch(input$mainPanel)
    validate({
      need(input$top >0 && input$top <= 436, "Please input a valid number")
    })
    return(filterCountyTable(input$series, input$top))
  })
  
  
}
  
  

