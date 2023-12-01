library(shiny)
source("main.R")
library(shinyjs)
library(plotly)



ui <- fluidPage(
  h1("Midwest Population Data Visualization"), 
  p("The data set is from midwest which is built into the ggplot2 package. Each row contains 
    demographic information about a county in each state:"),
  h2("Tab list:"),
  h4("Individual County Population Breakdown: Show the population breakdown for one certain
     county"),
  h4("County Ranking: Rank every county by the data series selected"),
  
  sidebarLayout(
    
    sidebarPanel(
      useShinyjs(),
      fluidRow(
        
        h3("Control Panel"),
        
        
        selectInput(
          inputId = "state",
          label = "Enter one state :",
          choices = stateNames,
          ),
        
        selectInput(
          inputId = "county",
          label = "Enter one county :",
          choices = countyNames,
        ),
        
        selectInput(
          inputId = "category",
          label = "Enter one Category :",
          choices = list("Race", "Poverty")
        ),
        
        selectInput(
          inputId = "series", 
          label = "Enter one Serie of Data :",
          choices = list("Total Population" = categoryNames[1], 
                         "Population Density" = categoryNames[2],
                         "White Population" = categoryNames[3],
                         "Black Population" = categoryNames[4],
                         "American-Indian Population" = categoryNames[5],
                         "Asian Population" = categoryNames[6],
                         "Others Population" = categoryNames[7],
                         "White Percentage" = categoryNames[8],
                         "Black Percentage" = categoryNames[9],
                         "American-Indian Percentage" = categoryNames[10],
                         "Asian Percentage" = categoryNames[11],
                         "Other Percentage" = categoryNames[12],
                         "Adults Population" = categoryNames[13],
                         "College Educated Percentage" = categoryNames[15],
                         "Known Poverty Population" = categoryNames[17],
                         "Known Poverty Percentage" = categoryNames[18],
                         "Below Poverty Percentage" = categoryNames[19],
                         "Child Below Poverty Percentage" = categoryNames[20],
                         "Adult Poverty Percentage" = categoryNames[21],
                         "Elderly Poverty Percentage" = categoryNames[22]
                         )
          
        ),
        
        numericInput(
          inputId = "top",
          label="# of Top County(s) to show",
          min = 1,
          max = 437,
          step=1, value =10
        )
      )
    ),
      
    mainPanel(
      tabsetPanel(id = "mainPanel",
                  type = "tabs",
    
                  tabPanel("Individual State Population Breakdown",
                            plotOutput("state"),
                  ),
                  tabPanel("County Ranking",
                           dataTableOutput("rank.table"))
      )
    )
  )
)
