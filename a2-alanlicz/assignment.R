# Assignment 2: Foundational Skills
#
# Before you get started:
# - Set your working directory to "source file location" using the Session menu
# - Run the following line of code to delete all variables in your workspace
#     (This will make it easier to test your script)
rm(list = ls())


### Set Up and Defining Variables #############################################

# Load the `stringr` package (install it if you haven't used it before)
# It has a variety of functions that make working with string variables easier


# Create a variable `my_age` that is equal to your age
my_age <- 20

# Create a variable `my_name` that is equal to your first name
my_name <- "Alan"

# Using a multiplication expression, create a variable `minutes_in_a_day` that
# is equal to the number of minutes in a day
minutes_in_a_day <- 24 * 60

# Using a multiplication expression, create a variable `hours_in_a_year` that
# is equal to the number of hours in a year
hours_in_a_year <- 365 * 24

# Create a variable `more_minutes_than_hours` that is a boolean (TRUE/FALSE)
# It should be TRUE if there are more minutes/day than hours/year
# Otherwise, it should be FALSE
more_minutes_than_hours <- minutes_in_a_day > hours_in_a_year

### Working with Functions ####################################################

# Write a function named `make_introduction()` that takes in
# two arguments called `name` and `age`
# This function should return a string value equal to
# "Hello, my name is {name}, and I'm {age} years old." but {name} and {age}
# should take on the values passed to the function
# Make sure that proper spacing is used (e.g., you shouldn't have multiple
# spaces between words, and you should have a space after a comma)
# Hint: Google search for "R paste paste0 difference"
#       Try reading a few pages to understand how to use each
make_introduction <- function(name, age) {
  return (sprintf("Hello, my name is %s, and I'm %d years old",name , age))
}

# Create a variable `my_intro` by passing your variables `my_name` and `my_age`
# into your `make_introduction()` function
my_intro <- make_introduction(my_name, my_age)
print(my_intro)

# Create a variable `casual_intro` by substituting "Hello, my name is",
# with "Hey, I'm" in your `my_intro` variable
casual_intro <- sub("Hello, my name is","Hey, I'm",my_intro)
print(casual_intro)

# Create a variable `loud_intro`, which is `my_intro` in all upper-case letters
# You should do this by using a function to convert your `my_intro` variable
# into all capital letters
loud_intro <- toupper(my_intro)


# Create a variable `quiet_intro`, which is `my_intro` in all lower-case letters
# You should do this by using a function to convert your `my_intro` variable
# into all lower-case letters
loud_intro <- tolower(my_intro)

# Create a new variable `capitalized_intro`, which is your `my_intro` variable
# but with each word capitalized
# Hint: Google search the stringr function `str_to_title`
capitalized  <- str_to_title(my_intro)

# Using the `str_count` function from stringr, create a variable `occurrences`
# that stores the # of times the letter "e" appears in `my_intro`
occurrences <- str_count(my_intro,"e")

# Write a function `double()` that takes in a value and
# returns that value multiplied by 2
double <- function(num) {
  return (2 * num)
}

# Using your `double()` function, create a variable `minutes_in_two_days`,
# which is the number of minutes in two days
minutes_in_two_days <- double(24 * 60)

# Write a function `cube()` that takes in a value and returns that value cubed
cube <- function(num) {
  return (num ^ 3)
}

# Create a variable `twenty_seven` by passing 3 to your `cube()` function
twenty_seven <- cube(3)

# Create a function `inches_to_cm` that converts from inches to centimeters
inches_to_cm <- function(length) {
  cm <- length * 2.54
  return (cm)
}

# Create a variable `inches_tall` that is your (numeric) height in inches
inches_tall <- 71

# Using your `inches_to_cm` function and your `inches_tall` variable,
# create a variable `cm_tall` that is your height in centimeters
cm_tall <- inches_to_cm(inches_tall)

# Write a function `has_more_zs` to determine which of two strings contains
# more instances of the letter "z". It should take as parameters two string
# variables and return the argument which has more occurrences of "z"
# If neither phrase contains the letter "z", it should return:
# "Neither string contains the letter z."
# If the phrases contain the same number of "z"s, it should return:
# "The strings have the same number of Zs."
# The function must work for both capital and lowercase "z"s.
has_more_zs <- function(string1, string2) {
  occurrences1 <- str_count(string1,"z")
  occurrences2 <- str_count(string2,"z")
  if (occurrences1 == 0 & occurrences2 == 0) {
    print("Neither string contains the letter z.")
  }
  else if (occurrences1 == occurrences2) {
    print("The strings have the same number of Zs.")
  }
  else if (occurrences1 > occurrences2) {
    print("First string has more Zs.")
  }
  else {
    print("Second string has more Zs.")
  }
}

# Create a variable `more_zs` by passing two strings of your choice to your
# `has_more_zs` function
more_zs <- has_more_zs("She couldn't decide of the glass was 
                      half empty or half full so she drank it.",
                      "The fifty mannequin heads floating in the pool kind 
                      of freaked them out.")

# Write a function `remove_digits` that will remove all digits
# (i.e., 0 through 9) from all elements in a *vector of strings*.
RemoveDigits <- function(A){
  for(i in 1:length(A)){
    A[i] <- gsub("[0-9]+","",A[i])
  }
  print("After removing the digits:")
  for(i in 1:length(A)){
    print(A[i])
  }
}

# Demonstrate that your approach is successful by passing a vector of courses
# to your function. For example, remove_digits(c("INFO 201", "CSE 142"))

RemoveDigits(c("INFO 201","CSE 142"))

### Vectors ###################################################################

# Create a vector `movies` that contains the names of six movies you like
movies <- c("Pirates of the Caribbean", "Matrix", "Bourne's Identity", 
           "Blade Runner", "Star Wars", "Shawshank Redemption")

# Create a vector `top_three` that only contains the first three movies of
# your `movies` list (e.g., index 1 through index 3)
# You should do this by subsetting the vector, do not just retype the movies
top_three <- movies[1:3]

# Using your vector and the `paste()` method, create a vector `excited` that
# adds the phrase " is a great movie!" to the end of each element in `movies`
excited <- paste(movies,c(" is a great movie!"))

# Create a vector `without_four` that omits the fourth element from `movies`
# You should do this by using a _negative index_
without_four <- movies[-4]

# Create a vector `multiples_of_4` that is every number divisible by 4
# between 4 and 400 (**2 points**)
multiples_of_4 <- seq(4,400,4)

# Create a vector `multiples_of_8` by filtering your `multiples_of_4` variable
# down to only elements that are divisible by 8.
# Hints:
# - See chapter 7.4 in the book for vector filtering
# - Google search "modulo operator in R"
multiples_of_8 <- multiples_of_4[multiples_of_4 %% 8 == 0]

# Create a vector `numbers` that is the numbers 700 through 999
numbers <- seq(700,999,1)

# Using the built in `length()` function, create a variable `numbers_len`
# that is equal to the length of the vector `numbers`
numbers_len <- length(numbers)

# Using the `mean()` function, create a variable `numbers_mean` that is
# equal to the mean of the vector `numbers`
numbers_mean <- mean(numbers)

# Using the `median()` function, create a variable `numbers_median`
# that is the median of the vector `numbers`
numbers_median <- median(numbers)

# Create a vector `lower_numbers` that the values in the `numbers` vector
# that are lower than `numbers_mean`
# Hint: Use vector filtering)
lower_numbers <- numbers[numbers < numbers_mean]

# Create a vector `higher_numbers` that the values in the `numbers` vector
# that are higher than `numbers_mean`
# Hint: Again, use vector filtering
higher_numbers <- numbers[numbers > numbers_mean]

### Lists #####################################################################

# Create a list called `summary_info` in which you'll store summary information
# about the `numbers` vector above.
# The list should contain the following _named_ keys:
# - `length`: in which you'll store the length of the vector
# - `mean`: in which you'll store the mean of the vector
# - `median`: in which you'll store the median of the vector
summary_info <- list(length, mean, median)

# Now, write a function called `summarize_vector` that takes in a vector of
# numbers, and returns a list of summary information about that vector
# (including the mean, median, and length)
summarize_vector <- function(vectors) {
  summary_info[1] <- length(vectors)
  summary_info[2] <- mean(vectors)
  summary_info[3] <- median(vectors)
  return(summary_info)
}

# Create a list `summary_1_to_100` by passing a vector of the values one
# through one hundred to your `summarize_vector` function
summary_1_to_100 <- summarize_vector(seq(1,100,1))

### Data Frames ###############################################################

# Create a vector `students` holding 1,000 values representing students
# They should have the values "Student 1", "Student 2",..., "Student 1000"
Student <- sprintf("Student %s",seq(1:1000))

# Create a vector `math_grades` that holds 1000 random values in it that
# represent grades in a math course
# These values should be normally distributed with a mean of 88 and a
# standard deviation of 10
# Hint: Lookup `rnorm()`
x2 <- runif(n = 1000, min = 1, max = 1000)
x1 <- as.integer(x2)
math_grades <- c(x1)
math_grades <- rnorm(math_grade, mean = 88, sd= 10)
math_grades <- as.integer(math_grades)

# In the `math_grades` vector, replace any values that are above 100 with
# the number 100
# Hint: Vector filtering
math_grades <- replace(math_grades, math_grades > 100, 100)

# Create a vector `spanish_grades` that holds 1000 random values in it that
# represent grades in a spanish course
# These values should be normally distributed with a mean of 85 and a
# standard deviation of 12
# Hint: Lookup `rnorm()`
x2 <- runif(n = 1000, min = 1, max = 1000)
x1 <- as.integer(x2)
spanish_grades <- c(x1)
spanish_grades <- rnorm(math_grades, mean = 85, sd = 12)
spanish_grades <- as.integer(spanish_grades)

# In the `spanish_grades` vector, replace any values that are above 100 with
# the number 100
# Hint: More vector filtering
# Hint: Vector filtering
spanish_grades <- replace(spanish_grades, spanish_grades > 100, 100)

# Create a data frame variable named `grades` by combining
# the vectors `students`, `math_grades`, and `spanish_grades`
# Make sure to properly handle strings
grades <- data.frame(Student, math_grades, spanish_grades, 
                     stringsAsFactors = FALSE)

# Create a variable `num_students` that counts the
# number of rows in your dataframe `grades`
num_students <- nrow(grades)

# Create a variable `num_courses` that counts the number of courses stored
# in the columns of your `grades` data frame
num_courses <- ncol(grades) - 1 


# Add a new column `grade_diff` to your data frame, which is equal to
# `grades$math_grades` minus `grades$spanish_grades`
grade_diff <- grades$math_grades - grades$spanish_grades

# Add another column `better_at_math` as a boolean (TRUE/FALSE) variable that
# indicates that a student got a better grade in math
better_at_math <- as.logical(math_grades > spanish_grades)

# Create a variable `num_better_at_math` that is the number
# (i.e., one numeric value) of students better at math
num_better_at_math <- length(better_at_math[better_at_math == TRUE])
