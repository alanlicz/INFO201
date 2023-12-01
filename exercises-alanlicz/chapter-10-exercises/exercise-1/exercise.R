# Exercise 1: creating data frames

# Create a vector of the number of points the Seahawks scored in the first 4 games
# of the season (google "Seahawks" for the scores!)
"Score" <- c(38, 35, 38, 31)

# Create a vector of the number of points the Seahwaks have allowed to be scored
# against them in each of the first 4 games of the season
"Allowed" <- c(25, 30, 31, 26)

# Combine your two vectors into a dataframe called `games`
"games" <- c("Score", "Allowed")

# Create a new column "diff" that is the difference in points between the teams
# Hint: recall the syntax for assigning new elements (which in this case will be
# a vector) to a list!
data <- data.frame(diff = 1:4,
                   won = 1:4)
data
#   diff
# 1  13
# 2  5
# 3  7
# 4  8



# Create a new column "won" which is TRUE if the Seahawks won the game
"won" <- c("won", "won", "won", "won")

# Create a vector of the opponent names corresponding to the games played
"opponent_name" <- c("Falcons", "Patriots", "Cowboys", "Dolphins")

# Assign your dataframe rownames of their opponents


# View your data frame to see how it has changed!

