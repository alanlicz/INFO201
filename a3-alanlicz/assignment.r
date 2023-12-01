# Assignment 3: Using Data
#
# Before you get started:
# - Set your working directory to "source file location" using the Session menu
# - Run the following line of code to delete all variables in your workspace
#     (This will make it easier to test your script)
rm(list = ls())


### Built in R Data ###########################################################

# In this section, you'll work with the variable `Titanic`, a data set which is
# built into the R environment.
# This data set actually loads in a format called a *table*
# See https://cran.r-project.org/web/packages/data.table/data.table.pdf
# Use the `is.data.frame()` function to test if it is a table.
is.data.frame(Titanic)

# Create a variable `titanic_df` by converting `Titanic` into a data frame;
# you can use the `data.frame()` function or `as.data.frame()`
# Hint: Be sure to **not** treat strings as factors!
titanic_df <- data.frame(Titanic, stringsAsFactors = FALSE)



# It's important to understand the _meaning_ of each column before analyzing it
# Using comments below, describe what information is stored in each column
# For categorical variables, list all possible values
# Class: [What ticket the passenger has]
# Sex: [The gender of the passenger]
# Age: [Whether the passenger is an adult or kid]
# Survived: [Did the passenger survived or not]
# Freq: [The count of the passenger at these types]


# Create a variable `children` that is a data frame containing only the rows
# from `titanic_df` with information about children on the Titanic
# Hints:
# - Filter rows using a vector of boolean values (like vector filtering)
# - See chapter 10.2.3
children <- titanic_df[titanic_df$Age == "Child", ]

# Create a variable `num_children` that is the total number of children.
# Hint: Remember the `sum()` function!
num_children <- sum(children$Freq)

# Create a variable `most_lost` that is the *row* from `titanic_df` with the
# largest absolute number of losses (people who did not survive)
# You can use multiple lines of code if you find that helpful
# to create this variable
# Hint: Filter for those who did not survive, then look for the row
lost_people <- titanic_df[titanic_df$Survived == "No", ]
max_lost <- max(lost_people$Freq)
most_lost <- lost_people[lost_people$Freq == max_lost, ]

# Define a function called `survival_rate()` that takes in two arguments which
# must be in *the following order*:
# - a ticket class (e.g., "1st", "2nd"), and
# - the dataframe itself (it's good practice to explicitly pass in data frames)
#
# This function should return a sentence that states the *survival rate*
# (# survived / # in group) of adult men and "women and children" in that
# ticketing class.
# It should read (for example):
# >"Of Crew class, 87% of women and children survived and 22% of men survived."
#
# This is a complicated function! We recommend the following approach:
# - Filter for all rows representing the given ticketing class and save the
#   new data frame to a variable
# - Using this data frame, filter for all rows representing Adult Males
# - Find the total number of men and total number of male survivors to
#   calculate the survival rate
# - Likewise, use the data frame to filter for all Children and Adult Females
# - Perform the above calculation for this group as well
#
# Other approaches are also acceptable, please comment to explain what you do!
survival_rate <- function(ticket_class, df) {
  passenger_at_that_class <- titanic_df[titanic_df$Class == ticket_class, ]
  passenger_survived <- passenger_at_that_class[passenger_at_that_class$Survived == "Yes", ]
  passenger_in_total <- sum(passenger_at_that_class$Freq)
  adult_men <- passenger_survived[passenger_survived$Age == "Adult" &
                                    passenger_survived$Sex == "Male", ]
  adult_women <- passenger_survived[passenger_survived$Age == "Adult" &
                                      passenger_survived$Sex == "Female", ]
  children <- passenger_survived[passenger_survived$Age == "Child", ]
  men_rate <- sum(adult_men$Freq) / passenger_in_total
  women_children_rate <- (sum(adult_women$Freq) + sum(children$Freq)) / passenger_in_total
  result <- sprintf("Of %s class, %.0f%% of women and children survived and %.0f%% of men survived."
                    , ticket_class, women_children_rate * 100, men_rate * 100)
}

# Create variables `first_survived`, `second_survived`, `third_survived` and
# `crew_survived` by passing each class and the `titanic_df` data frame
# to your `survival_rate` function
first_survived <- survival_rate("1st", titanic_df)
second_survived <- survival_rate("2nd", titanic_df)
third_survived <- survival_rate("3rd", titanic_df)
crew_survived <- survival_rate("Crew", titanic_df)
# What notable differences do you observe in the survival rates across classes?
# Note at least 2 observations.
# [crew women have the least survival rate]
# [higher class passenger have higher survival rate]


# What notable differences do you observe in the survival rates between the
# women and children versus the men in each group?
# Note at least 2 observations.
# [women and children have higher survival rate than men across all class except crew]
# [crew women have much less survival rate compared to other class]


### Reading in Data ###########################################################

# In this section, you'll work with .csv data of life expectancy by country
# First, download the csv file of `Life Expectancy` data from GapMinder:
# https://www.gapminder.org/data/
# You should save the .csv file into your `data` directory


# Before getting started, explore the GapMinder website to better understand
# the *original* source of the data (e.g., who calculated these estimates)
# Place a brief summary of the each data source here (e.g., 1 - 2 sentences
# per data source)
# [data compiled by Mattias Lindgren
#  Institute for Health Metrics and Evaluation, University of Washington
#  UN's forecasts from World Population Prospects 2019]


# Using the `read.csv` function, read the life_expectancy_years.csv file into
# a variable called `life_exp`. Make sure not to read strings as factors
life_exp <- read.csv(paste0("/Users/alanli/Documents/UW/INFO201/a3-alanlicz/",
                     "data/life_expectancy_years.csv"), 
                     stringsAsFactors = FALSE)
# Write a function `get_col_mean()` that takes a column name and a data frame
# and returns the mean of that column. Make sure to properly handle NA values
# Hint: `mean()` takes in an argument called `na.rm`
get_col_mean <- function(year, df) {
  col <- paste0("X", year)
  return(mean(df[ ,col], na.rm = TRUE))
}

# Create a list `col_means` that has the mean value of each column in the
# data frame (except the `Country` column). You should use your function above.
# Hint: Use an `*apply` function (lapply, sapply, etc.)
col_means <- lapply(seq(1800, 2100, 1), get_col_mean, df = life_exp)

# Create a variable `avg_diff` that is the difference in average country life
# expectancy between 1800 and 2018
avg_diff <-  col_means[[length(col_means)]] - col_means[[1]] 

# Create a column `life_exp$change` that is the change in life
# expectancy from 2000 to 2018. Increases in life expectancy should
# be *positive*
life_exp$change <- life_exp[, "X2018"] - life_exp[, "X2000"]

# Create a variable `most_improved` that is the *name* of the country
# with the largest gain in life expectancy. Make sure to filter NA values
# Hint: `max()` takes in an argument called `na.rm`
most_improved_country_num <- max(life_exp$change, na.rm = TRUE)
most_improved <- life_exp[life_exp$change == most_improved_country_num, 1]
most_improved <- most_improved[!is.na(most_improved)]

# Create a variable `num_small_gain` that has the *number* of countries
# whose life expectance has improved less than 1 year between 2000 and 2018
# Make sure to filter NA values
# Hint: Lookup `is.na()`
small_gain_country <- life_exp[life_exp$change < 1, 1]
num_small_gain <- length(small_gain_country)
num_small_gain <- num_small_gain[!is.na(num_small_gain)]

# Write a function `country_change()` that takes in a country's name,
# two years as numbers (not strings), and the `life_exp` data frame
# Parameters should be written *in the above order*
# It should return the phrase:
# "Between YEAR1 and YEAR2, the life expectancy in COUNTRY went DIRECTION by
# SOME_YEARS years".
# Make sure to properly indictate the DIRECTION as "up" or "down"
# Hint: Use an if/else statement to help compute DIRECTION
country_change <- function(country, year1, year2, life_exp) {
  row_num <- rownames(life_exp[life_exp$country == country, ])
  year1_X <- paste0("X", year1)
  year2_X <- paste0("X", year2)
  difference <- life_exp[row_num, year2_X] - life_exp[row_num, year1_X]
  if (difference > 0) {
    direction <- "up"
  } else {
    direction <- "down"
  }
  result <- sprintf("Between %i and %i, the life expectance in %s went %s by %.1f years.", 
                    year1, year2, country, direction, difference)
}

# Using your `country_change()` function, create a variable `sweden_change`
# that is the change in life expectancy from 1960 to 1990 in Sweden
sweden_change <- country_change("Sweden", 1960, 1990, life_exp)

# Write a function `compare_change()` that takes in two country names and your
# `life_exp` data frame as parameters, and returns a sentence that describes
# their change in life expectancy from 2000 to 2018 (the `change` column)
# For example, if you passed the values "China", and "Bolivia" to you function,
# It would return this:
# "The country with the bigger change in life expectancy was China (gain=6.9),
#  whose life expectancy grew by 0.6 years more than Bolivia's (gain=6.3)."
# Make sure to round your numbers to one digit (though only after calculations)
# Hint: Use an if/else statement to paste the countries in the correct order
compare_range <- function(country1, country2, df) {
  row_num1 <- rownames(df[df$country == country1, ])
  row_num2 <- rownames(df[df$country == country2, ])
  diff_1 <- df[row_num1, "X2018"] - df[row_num1, "X2000"]
  diff_2 <- df[row_num2, "X2018"] - df[row_num2, "X2000"]
  if (diff_2 > diff_1) {
    temp <- country1
    country1 <- country2
    country2 <- temp
    temp <- diff_1
    diff_1 <- diff_2
    diff_2 <- temp
  }
  diff <- diff_1 - diff_2
  result <- sprintf("The country with the bigger change in life expectancy was %s (gain=%.1f), 
                    whose life expectancy grew by %.1f years more than %s's(gain=%.1f)",
                    country1, diff_1, diff, country2, diff_2)
  result <- strwrap(result, width = 10000, simplify = TRUE)
}

# Using your `bigger_change()` function, create a variable `usa_or_france`
# that describes who had a larger gain in life expectancy (the U.S. or France)
usa_or_france <- compare_range("United States", "France", life_exp)

# Write your `life_exp` data.frame to a new .csv file to your
# data/ directory with the filename `life_exp_with_change.csv`.
# Make sure not to write row names.
write.csv(life_exp, "/Users/alanli/Documents/UW/INFO201/a3-alanlicz/data/life_exp_with_change.csv",
          row.names = FALSE)
