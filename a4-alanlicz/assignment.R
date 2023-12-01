# A4 Data Wrangling

# We provide this line to delete all variables in your workspace.
# This will make it easier to test your script.
rm(list = ls())

# Loading and Exploring Data -------------------------------- (**29 points**)

# First, search online for a dplyr cheatsheet and put the link to one you
# like in the comments here (it's ok if the link makes the line too long):
# - <https://rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf>


# To begin, you'll need to download the Kickstarter Projects data from the
# Kaggle website: https://www.kaggle.com/kemical/kickstarter-projects
# Download the `ks-projects-201801.csv` file into a new folder called `data/`

# Load the `dplyr` package
library(dplyr)

# If your computer isn't in English, you made need to use this line of code
# to get the csv to load correctly (if the data gets messed up a few rows in):
# Sys.setlocale("LC_ALL", "English")

# Load your data, making sure to not interpret strings as factors.
ks_df <- read.csv(paste0("/Users/alanli/Documents/UW/INFO201/a4-alanlicz/data/archive/",
                  "ks-projects-201801.csv"), stringsAsFactors = FALSE)

# To start, write the code to get some basic information about the dataframe:
# - What are the column names?
# - How many rows is the data frame?
# - How many columns are in the data frame?
col_names <- colnames(ks_df) 
col_number <- ncol(ks_df)
row_number <- nrow(ks_df)
# Use the `summary` function to get some summary information
summary(col_names, col_number, row_number)

# Unfortunately, this doesn't give us a great set of insights. Let's write a
# few functions to try and do this better.
# First, let's write a function `get_col_info()` that takes as parameters a
# column name and a dataframe. If the values in the column are *numeric*,
# the function should return a list with the keys:
# - `min`: the minimum value of the column
# - `max`: the maximum value of the column
# - `mean`: the mean value of the column
# If the column is *not* numeric and there are fewer than 10 unique values in
# the column, you should return a list with the keys:
# - `n_values`: the number of unique values in the column
# - `unique_values`: a vector of each unique value in the column
# If the column is *not* numeric and there are 10 or *more* unique values in
# the column, you should return a list with the keys:
# - `n_values`: the number of unique values in the column
# - `sample_values`: a vector containing a random sample of 10 column values
# Hint: use `typeof()` to determine the column type

get_col_info <- function(col_name, df) {
  col_type <- typeof(df[, col_name])
  if (col_type == "double" | col_type == "integer") {
    min <- min(df[, col_name], na.rm = TRUE)
    max <- max(df[, col_name], na.rm = TRUE)
    mean <- mean(df[, col_name], na.rm = TRUE)
    num_list <- list("min" = min, "max" = max, "mean" = mean)
    return(num_list)
  } else if(length(unique(df[, col_name])) < 10){
    n_values <- length(unique(df[, col_name]))
    unique_values <- unique(df[, col_name])
    value_list <- list("n_values" = n_values, "unique_values" = unique_values)
    return(value_list)
  } else {
    n_values <- length(unique(df[, col_name]))
    unique_values <- sample(unique(df[, col_name]), 10)
    value_list <- list("n_values" = n_values, "unique_values" = unique_values)
    return(value_list)
  }
}

# Demonstrate that your function works by passing a column name of your choice
# and the kickstarter data to your function. Store the result in a variable
# with a meaningful name
name_stats <- get_col_info("name", ks_df)

# To take this one step further, write a function `get_summary_info()`,
# that takes in a data frame  and returns a *list* of information for each
# column (where the *keys* of the returned list are the column names, and the
# _values_ are the summary information returned by the `get_col_info()` function
# The suggested approach is to use the appropriate `*apply` method to
# do this, though you can write a loop
get_summary_info <- function(df) {
  info <- list()
  for (col_name in colnames(df)){
    info[[col_name]] <- get_col_info(col_name, df)
  }
  return(info)
}

# Demonstrate that your function works by passing the kickstarter data
# into it and saving the result in a variable
summary_info <- get_summary_info(ks_df)

# Take note of 3 observations that you find interesting from this summary
# information (and/or questions that arise that want to investigate further)
# Although there are 375765 items, only 14 currency are used.
# Some items have no backers at all
# Some of the goal value is 0

# Asking questions of the data ----------------------------- (**29 points**)

# Write the appropriate dplyr code to answer each one of the following questions
# Make sure to return (only) the desired value of interest (e.g., use `pull()`)
# Store the result of each question in a variable with a clear + expressive name
# If there are multiple observations that meet each condition, the results
# can be in a vector. Make sure to *handle NA values* throughout!
# You should answer each question using a single statement with multiple pipe
# operations!
# Note: For questions about goals and pledged, use the usd_pledged_real
# and the usd_goal_real columns, since they standardize the currancy.


# What was the name of the project(s) with the highest goal?
name_df <- select(ks_df, name, goal)
max_goal <- filter(name_df, goal == max(goal))
max_name <- pull(max_goal, name)

# What was the category of the project(s) with the lowest goal?
category_df <- select(ks_df, category, goal)
lowest_goal <- filter(category_df, goal == min(goal))
min_category <- pull(lowest_goal, category)

# How many projects had a deadline in 2018?
# Hint: start by googling "r get year from date" and then look up more about
# different functions you find
deadline_df <- select(ks_df, deadline)
for (value in deadline_df) {
  year <- substring(value,1,4)
}
count <- length(which(year == 2018))
# What proportion of projects weren't marked successful (e.g., failed or live)?
# Your result can be a decimal
state_df <- select(ks_df, state)
count <- length(which(state_df == "successful"))
percentage <- count/nrow(ks_df)
# What was the amount pledged for the project with the most backers?
pledge_df <- select(ks_df, usd.pledged, backers)
max_pledged <- filter(pledge_df, backers == max(backers))
amount <- pull(max_pledged, usd.pledged)

# Of all of the projects that *failed*, what was the name of the project with
# the highest amount of money pledged?
state_df <- select(ks_df, name, state, usd.pledged)
fail_df <- filter(state_df, state == "failed")
highest_pledged <- filter(fail_df, usd.pledged == max(usd.pledged, na.rm = TRUE))
name_highest_ple <- pull(highest_pledged, name)
# How much total money was pledged to projects that weren't marked successful?
state_df2 <- select(ks_df, state, usd.pledged)
unsuccessful <- filter(state_df2, state != "successful")
amount_vector <- pull(unsuccessful, usd.pledged)
amount_total <- sum(amount_vector, na.rm = TRUE)
# Performing analysis by *grouped* observations ----------------- (31 Points)

# Which category had the most money pledged (total)?
grouped_category <- group_by(ks_df, category)
grouped_category_pledged <- summarize(grouped_category, usd.pledged = sum(usd.pledged, 
                                                                          na.rm = TRUE))
most_pledged_category <- filter(grouped_category_pledged, usd.pledged == max(usd.pledged))
most_pledged_category_name <- pull(most_pledged_category, category)
# Which country had the most backers?
grouped_country <- group_by(ks_df, country)
grouped_country_backers <- summarize(grouped_country, backers = sum(backers, na.rm = TRUE))
most_backers <- filter(grouped_country_backers, backers == max(backers))
most_backers_country = pull(most_backers, country)
# Which year had the most money pledged (hint: you may have to create a new
# column)?
# Note: To answer this question you can choose to get the year from either
# deadline or launched dates.
launch_df <- select(ks_df, usd.pledged, launched)
for (value in launch_df) {
  year <- substring(value,1,4)
}
launch_df$launch_year <- year

group_year <- group_by(launch_df, launch_year)
year_pledged <- summarize(group_year, pledged = sum(usd.pledged, na.rm = TRUE))
most_pledged <- filter(year_pledged, pledged == max(pledged))
most_pledged_year <- pull(most_pledged, launch_year)
# Write one sentance below on why you chose deadline or launched dates to
# get the year from:
#People pay the most attention on the item when they launch

# What were the top 3 main categories in 2018 (as ranked by number of backers)?
ranking_backers <- arrange(grouped_country_backers, -backers)
top_three <- ranking_backers[1:3, ]
top_three_name <- pull(top_three, country)
# What was the most common day of the week on which to launch a project?
# (return the name of the day, e.g. "Sunday", "Monday"....)
ks_df$weekday <- weekdays(as.Date(ks_df$launched)) 
weekday_count <- table(ks_df$weekday)
most_common <- max(weekday_count)
day <- names(which(weekday_count == most_common))
# What was the least successful day on which to launch a project? In other
# words, which day had the lowest success rate (lowest proportion of projects
# that were marked successful )? This might require creative problem solving...
# Hint: Try googling "r summarize with condition in dplyr"
least_success_prop <- ks_df %>%
  mutate(day = weekdays(as.Date(launched))) %>%
  group_by(day) %>%
  summarise(total = n(), not_success = sum(state != "successful"), 
            perc = not_success * 100 / total ) %>%
  arrange(-perc) %>%
  select(day, perc)
least_success_day <- least_success_prop[least_success_prop$day == max(least_success_prop$day),]
