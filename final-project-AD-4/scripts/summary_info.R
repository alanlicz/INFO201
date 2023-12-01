library("dplyr")

summary_info <- read.csv("./data/EV_range_by_model.csv")
summary_info$LIST.PRICE_2 <- gsub("[$]", "", summary_info$LIST.PRICE)
summary_info$LIST.PRICE_2 <-
  as.numeric(gsub(",", "", summary_info$LIST.PRICE_2))
summary_info$COST.MILE_2 <- gsub("[$]", "", summary_info$COST.MILE)
summary_info$COST_MILE_2 <- as.numeric(gsub(",", "", summary_info$COST.MILE_2))

get_summary_info <- function(dataset) {
  result <- list()
  result$total <- nrow(dataset)
  result$longest_range <- dataset %>%
    filter((RANGE.Miles.) == max(RANGE.Miles.)) %>%
    pull(VEHICLE)
  result$shortest_range <- dataset %>%
    filter((RANGE.Miles.) == min(RANGE.Miles.)) %>%
    pull(VEHICLE)

  result$most_expensive <- dataset %>%
    filter((LIST.PRICE_2) == max(LIST.PRICE_2)) %>%
    pull(VEHICLE)
  result$least_expensive <- dataset %>%
    filter((LIST.PRICE_2) == min(LIST.PRICE_2)) %>%
    pull(VEHICLE)
  result$best_value <- dataset %>%
    filter((COST_MILE_2) == min(COST_MILE_2)) %>%
    pull(VEHICLE)
  result$worst_value <- dataset %>%
    filter((COST_MILE_2) == max(COST_MILE_2)) %>%
    pull(VEHICLE)
  return(result)
}

get_summary_info(summary_info)
