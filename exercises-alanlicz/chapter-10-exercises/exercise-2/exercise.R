# Exercise 2: working with data frames

# Create a vector of 100 employees ("Employee 1", "Employee 2", ... "Employee 100")
# Hint: use the `paste()` function and vector recycling to add a number to the word
# "Employee"
Employee <- paste("Employee ", 1:100)
print(Employee)

# Create a vector of 100 random salaries for the year 2017
# Use the `runif()` function to pick random numbers between 40000 and 50000
x2 <- runif(n =100, min = 40000, max = 50000)
x1 <- as.integer(x2)
salary <- c(x1)

# Create a vector of 100 annual salary adjustments between -5000 and 10000.
# (A negative number represents a salary decrease due to corporate greed)
# Again use the `runif()` function to pick 100 random numbers in that range.
x2 <- runif(n =100, min = -5000, max = 10000)
x1 <- as.integer(x2)
adjustment <- c(x1)

# Create a data frame `salaries` by combining the 3 vectors you just made
# Remember to set `stringsAsFactors=FALSE`!
salaries <- data.frame(Employee, Salary, Adjustment, stringsAsFactors = FALSE)


# Add a column to the `salaries` data frame that represents each person's
# salary in 2018 (e.g., with the salary adjustment added in).
Salary_in_2018 <- salaries$salary + salaries$adjustment
salaries$Salary_in_2018 <- Salary_in_2018

# Add a column to the `salaries` data frame that has a value of `TRUE` if the 
# person got a raise (their salary went up)
Raise_or_not <- salaries$adjustment > 0
salaries$Raise_or_not <- Raise_or_not

### Retrieve values from your data frame to answer the following questions
### Note that you should get the value as specific as possible (e.g., a single
### cell rather than the whole row!)

# What was the 2018 salary of Employee 57
salaries[5, 4]

# How many employees got a raise?
print(length(salaries$Raise_or_not[Raise_or_not == TRUE]))

# What was the dollar value of the highest raise?
print(max(salaries$adjustment))

# What was the "name" of the employee who received the highest raise?
print(salaries[salaries$adjustment == 9899, "Employee"])

# What was the largest decrease in salaries between the two years?
print(min(salaries$adjustment))

# What was the name of the employee who recieved largest decrease in salary?
print(salaries[salaries$adjustment == -4994, "Employee"])

# What was the average salary change?
print(mean(salaries$adjustment))

# For people who did not get a raise, how much money did they lose on average?
lose <- salaries[salaries$adjustment < 0, ]
print(mean(lose$adjustment))



## Consider: do the above averages match what you expected them to be based on 
## how you generated the salaries?
yes
# Write a .csv file of your salary data to your working directory
write.csv(salaries, file = "/Users/alanli/Documents/UW/INFO201/exercises-alanlicz/chapter-10-exercises/exercise-2/salaries_sheet.csv", row.names = FALSE)

