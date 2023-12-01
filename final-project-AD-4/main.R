# style check
library(lintr)
lintr::lint("main.R")

# Load all the libraries needed
library(plotly)
library(dplyr)
library(stringr)
library(rlang)

###Page 1###
# data for price vs range graph
range_vs_price <- read.csv("./data/EV_range_by_model.csv")

# max and min for range slider
miles_range <- range(range_vs_price$RANGE.Miles.)


###Page 2###
df <- readr::read_csv("./data/EV_sales_by_model.csv")

# Get all the rows in the file except for the last row
df <- df[1:55, ]

# Filter the dataset to contain only the sales of electrical vehicles
ev_sales <- df %>%
  filter(Type == "EV")
ev_sales <- subset(ev_sales, select = -c(Type, Total))

# Get all the model names
ev_models <- ev_sales[["Vehicle"]]


# Build Bar Chart
build_bar_chart <- function(data, model) {
  data_sales <-
    ev_sales %>%
    filter(Vehicle == model) %>%
    gather(
      "year", "sales", "2011", "2012", "2013", "2014", "2015", "2016",
      "2017", "2018", "2019"
    )
  print(data_sales)
  # plot the data
  data_sales$sales2 <- as.numeric(gsub(",", "", data_sales$sales))
  p <- ggplot(
    data = data_sales,
    aes(
      x = year, y = sales2,
      text = paste0(
        "The sales of ", Vehicle, " in ", year,
        " was ", sales2, "."
      )
    )
  ) +
    geom_bar(stat = "identity") +
    labs(
      title = paste0("EV Sales Chosen vs Year"),
      x = "year",
      y = "sales"
    )
  return(ggplotly(p, tooltip = "text"))
}


###Page 3###
ev_ranges <- readr::read_csv("./data/EV_range_by_model.csv")
get_range_plot <- function(series) {
  result <- ev_ranges %>% select(VEHICLE, series)

#Builds chart
  if (series == "LIST PRICE") {
    plot <-
      #tooltip information
      ggplot(data = result, aes(x = VEHICLE, y = `LIST PRICE`, text = paste0(
        "The list price of ", VEHICLE, " is ", `LIST PRICE`, "."
      ))) +
      #creates brand vs price chart
      geom_bar(stat = "identity") +
      labs(title = paste0("EV Listing Price"), x = "Brand", y = "Price") +
      theme(axis.text.x = element_text(angle = 45, vjust = 0.3, hjust = 0.5)) +
      theme(axis.text.y = element_text(size = 6))
    return(ggplotly(plot, tooltip = "text"))
  } else if (series == "RANGE(Miles)") {
    plot <-
      #tooltip information
      ggplot(data = result, aes(x = VEHICLE, y = `RANGE(Miles)`, text = paste0(
        "The range of ", VEHICLE, " is ", `RANGE(Miles)`, "."
      ))) +
      #creates brand vs range chart
      geom_bar(stat = "identity") +
      labs(title = paste0("EV Range"), x = "Brand", y = "Range") +
      theme(axis.text.x = element_text(angle = 45, vjust = 0.3, hjust = 0.5)) +
      theme(axis.text.y = element_text(size = 6))
    return(ggplotly(plot, tooltip = "text"))
  } else {
    plot <-
      #tooltip information
      ggplot(data = result, aes(x = VEHICLE, y = `COST/MILE`, text = paste0(
        "The range of ", VEHICLE, " is ", `COST/MILE`, "."
      ))) +
      #creates brand vs cost per mile chart
      geom_bar(stat = "identity") +
      labs(title = paste0("EV Cost/Mile"), x = "Brand", y = "Cost") +
      theme(axis.text.x = element_text(angle = 45, vjust = 0.3, hjust = 0.5)) +
      theme(axis.text.y = element_text(size = 6))
    return(ggplotly(plot, tooltip = "text"))
  }
}
