library("ggplot2")
ev_sales_model <- read.csv("../data/EV_sales_by_model.csv",
  stringsAsFactors = FALSE
)
# creates pie chart based on type of EV
phev_vs_ev <- function(dataset) {
  type <- dataset[1:55, c("Vehicle", "Type")]
  result <- ggplot(
    data = type,
    title = "Type",
    aes(x = factor(1), fill = Type)
  ) +
    geom_bar(width = 1) +
    coord_polar(theta = "y") +
    theme_void() +
    labs(
      title =
        "All-Electric vs Plug-in Hybrid Electric Vehicles"
    )
  return(result)
}
