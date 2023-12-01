library("ggplot2")
# Creates scatterplot based on list price and range of EV
price_vs_range <- function(dataset) {
  result <- ggplot(data = dataset) +
  geom_point(mapping = aes(x = RANGE.Miles., y = LIST.PRICE), color = "blue") +
    labs(
      title = "Electric Vehicle List Price vs Range in Miles",
      x = "Range in Miles",
      y = "EV List Price"
    )
  return(result)
}
