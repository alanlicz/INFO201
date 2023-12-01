# Exercise 3: working with built-in data sets

# Load R's "USPersonalExpenditure" dataset using the `data()` function
# This will produce a data frame called `USPersonalExpenditure`
data("USPersonalExpenditure")


# The variable `USPersonalExpenditure` is now accessible to you. Unfortunately,
# it's not a data frame (it's actually what is called a matrix)
# Test this using the `is.data.frame()` function
print(is.data.frame(example))

# Luckily, you can pass the USPersonalExpenditure variable as an argument to the
# `data.frame()` function to convert it a data farm. Do this, storing the
# result in a new variable
expenditure2 <- data.frame(datasets::USPersonalExpenditure, 
                           stringsAsFactors = FALSE) 
print(expenditure2)

# What are the column names of your dataframe?
print(colnames(expenditure2))

## Consider: why are they so strange? Think about whether you could use a number 
## like 1940 with dollar notation!
#Because of the encoding
# What are the row names of your dataframe?
print(rownames(expenditure2))

# Add a column "category" to your data frame that contains the rownames
expenditure2$category <- rownames(expenditure2) 

# How much money was spent on personal care in 1940?
print(expenditure2["Personal Care", "X1940"])

# How much money was spent on Food and Tobacco in 1960?
print(expenditure2["Food and Tavacco", "X1960"])

# What was the highest expenditure category in 1960?
highest <- max(expenditure2$X1960)
print(expenditure2[expenditure2$X1960 == highest, "X1960"])

# Define a function `lowest_category` that takes in a year as a parameter, and
# returns the lowest spending category of that year
lowest_category <- function(year) {
  col <- paste0("X", year)
  expenditure2$category[expenditure2[, col] == min(expenditure2[, col])]
}

# Using your function, determine the lowest spending category of each year
# Hint: use the `sapply()` function to apply your function to a vector of years
lowest <- sapply(seq(1940, 1960, 5), lowest_category)
