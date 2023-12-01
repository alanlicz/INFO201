library(dplyr)

# takes a dataset as a parameter and returns a table of the total sales of
# each model type in descending order
total_sales_of_each_type <- function(data) {
  # Get all the rows in the file except for the last row
  data <- data[1:55, ]
  # groups the data by model type
  # computes the sum of total sales for each type
  # and sorts them in descending order
  result <- data %>%
    group_by(Type) %>%
    summarise(
      total_sales_of_each_type =
        sum(as.numeric(Total), na.rm = TRUE)
    ) %>%
    arrange(-total_sales_of_each_type)
  return(result)
}
