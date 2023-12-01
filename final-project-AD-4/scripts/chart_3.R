library("ggplot2")
library("tidyr")

sales_by_yr_chart <- function(dataset) {
  # Only pulled sales data across all years from 2011-2019
  sales_by_year <- subset(dataset, select = -c(Type, Total, Vehicle))
  sales_by_year_reshaped <- sales_by_year[56, ] %>%
    # Reshaped dataframe using tidyr
    gather(years, total_sales)
  # Bar chart based on total sales and years
  result <- ggplot(data = sales_by_year_reshaped) +
    geom_col(mapping = aes(x = years, y = total_sales), color = "light blue") +
    labs(
      title = "Total Electric Vehicle Sales per year from 2011-2019",
      x = "Years",
      y = "Total Sales"
    )
  return(result)
}
