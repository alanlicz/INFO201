# style check
library(lintr)
lintr::lint("app_ui.R")
# Load all the libraries needed
library(shiny)
library(plotly)
source("main.R")
library(ggplot2)
library(tidyr)
library(dplyr)

# Interactive page 1 with EV Price vs Range graph
page1_panel <- tabPanel(
  "EV Price vs Range in Miles",
  sidebarLayout(
    sidebarPanel(
      # Allows users to view only EVs with certain ranges
      range_input <- sliderInput(
        inputId = "range_choice",
        label = "Range (Miles)",
        # Min and max values of the range for the limits of the slider
        min = miles_range[1],
        max = miles_range[2],
        value = miles_range
      )
    ),
    # Description of graph
    mainPanel(
      h1("EV Price vs Range in Miles"),
      p("This chart is intended to show the relationship between the cost of a
         car and how far can run, answering the question: does a more expensive
         EV mean that it will have a longer range?"),
      # Shows scatter plot chart
      plotlyOutput("first_scatter")
    )
  )
)

# Define a variable `scatter_sidebar_content` that is a `sidebarPanel()` for
# our second (scatter) page that contains:
page2_sidebar_content <- sidebarPanel(
  # A selectInput widget to select variable to plot
  selectInput(
    "plotvar",
    label = "Model to Plot",
    choices = ev_models
  )
)


# Define a variable `scatter_main_content` that is a `mainPanel()` for the
# second (bar chart) page that contains the `plotlyOutput()`
page2_main_content <- mainPanel(
  h1("Ev Model Sales by Year from 2011-2019"),
  p("This plot is intended to show the sales of each electrical vehicle model
 from 2011 to 2019, answering the questions: What does the trend of
 EV sales look like in general and for each model?
   Will EV sales keep increasing in the next few years?"),
  plotlyOutput("bar")
)

# Create a variable `scatter_panel` that stores a `tabPanel()` for the 2nd page
# It should include the following:
page2_panel <- tabPanel(
  "EV Sales by Year",
  # sidebar layout for this tab (page)
  sidebarLayout(
    # Display `scatter_sidebar_content`
    page2_sidebar_content,
    # Display `scatter_main_content`
    page2_main_content
  )
)

series_names <- colnames(ev_ranges)
page3_sidebar_content <- sidebarPanel(
  # A selectInput widget to select variable to plot
  selectInput(
    "series",
    label = "Data Series",
    choices = c("RANGE(Miles)", "LIST PRICE", "COST/MILE")
  )
)


# Define a variable `scatter_main_content` that is a `mainPanel()` for the
# third (bar chart) page that contains the `plotlyOutput()`
page3_main_content <- mainPanel(
  h1("EV Types vs Cost, Price, & Cost per Mile"),
  p("This bar chart compares different EV Models in terms of different criteria
  which helps consumers understand which EV model they should choose depending
  what they most value: range, list price, cost per mile, or a combination of
  all three."),

  plotlyOutput("bar_range")
)

# Create a variable `scatter_panel` that stores a `tabPanel()` for the 3rd page
page3_panel <- tabPanel(
  "EV Types vs Cost, Price, & Cost per Mile",

  # Sidebar layout for this tab
  sidebarLayout(
    # Display `scatter_sidebar_content`
    page3_sidebar_content,

    # Display `scatter_main_content`
    page3_main_content
  )
)

# Introductory Paragraph
intro_page <- tabPanel(
  "Introduction",
  fluidPage(
    h1("Analysis of Electric Vehicles Market"),
    p(
      "Our project analyzes the market trends of", strong("electric vehicles"),
      "during the 2010s.  We believe that this is a very important field to
      discuss as electric vehicles continue grow their popularity.  Given the
      increasing consciousness of younger generations of the perils of climate
      change, and its increasing impact on our daily lives, greater numbers of
      people are turning to electric vehicles as an eco-friendly alternative to
      gasoline-powered vehicles, the market share of electric vehicles should
      increase, especially as innovations continue to increase their power and
      lower their cost to manufacture.  Therefore, in our eyes, electric
      vehicles and their market constitute a rich field of study."
      ),
      p(
        "Our data was sourced from 2 different locations:",
        HTML(
        '<a href="https://www.anl.gov/es/
        light-duty-electric-drive-vehicles-monthly-sales-updates">
        The Argonne National Laboratory</a>'),
        ", and",
        HTML(
        '<a href="https://www.visualcapitalist.com/
        range-evs-major-highway-routes/">
        Visual Capitalist</a>'),
        "."
      ),
      img("Tesla Model S Long Range Plus",
          src = "tesla-model-s.jpg",
          height = "50%",
          width = "50%",
          align = "center"
          ),
    tags$p(
      id = "footer",
      "This vehicle had the longest range of all EVs, per our data."
    )
  )
)

# Conclusion Page with Summary Takeaways
conclusion_page <- tabPanel(
  "Conclusion",
  fluidPage(
    h1("Summary Takeaways"),
    h3("Price vs Range"),
    p("Even though there is a general trend that more
    expensive electric vehicles have longer ranges, there is not a strong
    relationship between the cost of a car and how far it runs. For example, on
    the EV Price vs Range graph, there is a $69,850 car with a range of 234
    miles and a $39,090 car with a range of 239 miles. Therefore, when
    considering purchasing an EV, consumers should research the specs rather
    than assuming that an expensive car will automatically have long range."),
    h3("EV Sales by Year"),
    p("These graphs, taken vehicle-by-vehicle, show that technology's rapid
    progress has rendered many of the early models of electric vehicles
      obsolete.  Most of the best-selling EVs from the first half of the decade
      have fallen out of the market; a good example is the Honda Fit EV, which
      had strong sales from 2013-2014 but fell off the market completely just
      two years after.  These EVs have been replaced by newer models, both from
      the same companies and from new ones like Tesla.  This trend can be
      expected to continue into the future, as the bounds of EV technology
      continue to be pushed."),
    h3("EV Types vs Cost, Price, & Cost per Mile"),
    p("These charts show how, just as a higher price does not necessarily
      correlate to a better electric vehicle, so can a lower cost be misleading
      in terms of value.  Take the examples of the Chevrolet Bolt EV and the
      Fiat 500e; while the two vehicles are similarly priced, between $33,000
      and $37,000, the 500e has more than", strong("double"),
      "the cost per mile of the Bolt.
      Because of this, consumers would be wise to do much research
      before committing to purchasing an electric vehicle, as its pros and cons
      may not be readily apparent.")
)
)

# Define a variable `ui` storing a `navbarPage()` element containing
# your two pages defined above
ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    "Electric Vehicles Market Analysis",
    intro_page,
    page1_panel,
    page2_panel,
    page3_panel,
    conclusion_page
  )
)
