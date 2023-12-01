library(dplyr)
library(knitr)
library(tidyr)
library(leaflet)
library(ggplot2)

gun_shooting <- read.csv("/Users/alanli/Documents/UW/INFO201/a5-alanlicz/data/shootings-2018.csv",
                         stringsAsFactors = FALSE)
gun_shooting_occurencies <- nrow(gun_shooting)
lives_lost <- sum(gun_shooting$num_killed)

most_impact_city <- gun_shooting %>%
  group_by(city) %>%
  summarize(num_killed = sum(num_killed)) %>%
  filter(num_killed == max(num_killed)) %>%
  pull(city)

most_horrible_day <- gun_shooting %>%
  group_by(date) %>%
  summarize(num_killed = sum(num_killed)) %>%
  filter(num_killed == max(num_killed)) %>%
  pull(date)

most_impact_state <- gun_shooting %>%
  group_by(state) %>%
  summarize(num_killed = sum(num_killed)) %>%
  filter(num_killed == max(num_killed)) %>%
  pull(state)

summary_table <- gun_shooting %>%
  group_by(state) %>%
  summarize(Death = sum(num_killed)) %>%
  arrange(-Death)

state_analysis_table <- knitr::kable(summary_table,
                                    caption = "Gun shooting death number ranking by state"
)

date_of_event <- gun_shooting %>%
  filter(num_killed == max(num_killed)) %>%
  pull(date)

address <- gun_shooting %>%
  filter(num_killed == max(num_killed)) %>%
  pull(address)

city <- gun_shooting %>%
  filter(num_killed == max(num_killed)) %>%
  pull(city)

state <- gun_shooting %>%
  filter(num_killed == max(num_killed)) %>%
  pull(state)

number_killed <- gun_shooting %>%
  filter(num_killed == max(num_killed)) %>%
  pull(num_killed)

number_injured <- gun_shooting %>%
  filter(num_killed == max(num_killed)) %>%
  pull(num_injured)


location <- paste("Address: ", (gun_shooting$address), ", ",
                  (gun_shooting$city), ", ", (gun_shooting$state),
                  sep = ""
)

total_number_killed <- paste(
  "Number of People Killed: ",
  (gun_shooting$num_killed)
)
total_number_injured <- paste(
  "Number of People Injured: ",
  (gun_shooting$num_injured)
)
hover_info <- paste(
  sep = "\n", location, "<br>",
  total_number_killed, "<br>",
  total_number_injured
)

map <- leaflet() %>%
  addTiles() %>%
  addCircleMarkers(
    lng = gun_shooting$long, lat = gun_shooting$lat, radius = gun_shooting$total,
    label = lapply(hover_info, htmltools::HTML)
  )

plot_graph <- ggplot(data = gun_shooting, aes(state, num_killed)) + geom_bar(stat="identity")  +
  theme(axis.text.x = element_text(size  = 10, angle = 45, hjust = 1, vjust = 1))

