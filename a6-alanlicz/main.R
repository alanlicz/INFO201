library(dplyr)
library(tidyr)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(plotly)
library(reshape2)
library(rlang)

df <- data.frame(midwest)
countyNames <- df[ , 2]
categoryNames <- colnames(midwest)
stateNames <- c("IL", "IN", "MI", "OH", "WI")
categoryNames <- categoryNames[c(5:26)]

vec <- c("popwhite", "popblack", "popasian", "popamerindian","popother")
categories <- list("Race" = vec, "Poverty", "Education")



filterCountyTable <- function(series, top){
  result.data <-
    midwest %>%
    select(county, state, series) %>%
    arrange(-!!sym(series)) %>% 
    top_n(top)
  return(result.data)
}


getPlot <- function(category, state_in) {
  if (category == "Race"){
    data.state <- 
      df %>%
      group_by(state) %>%
      summarise(White = sum(popwhite), Black = sum(popblack), Asian = sum(popasian), 
                American_Indian = sum(popamerindian), Others = sum(popother)) %>%
      filter(state == state_in) %>%
      gather("race", "Percentage", White, Black, Asian, American_Indian, Others) 
    plot <-
      ggplot(data = data.state, aes(x="", y=Percentage, fill=race)) +
      geom_bar(stat="identity") +
      coord_polar("y", start=0) +
      ggtitle("Race breakdown")
    return(plot)
  }
  if (category == "Poverty"){
    data.state <- 
      df %>%
      group_by(state) %>%
      summarise(Adult = mean(percadultpoverty), Child = mean(percchildbelowpovert), 
                Elder = mean(percelderlypoverty)) %>%
      filter(state == state_in) %>%
      gather("Age", "Percentage", Adult, Child, Elder) 
    print(data.state)
    plot <-
      ggplot(data = data.state, aes(x=Age, y=Percentage)) +
      geom_bar(stat="identity") +
      ggtitle("Poverty breakdown")
    return(plot)
  }
}


