# Exercise 2: using `*apply()` functions

# Create a *list* of 10 random numbers. Use the `runif()` function to make a 
# vector of random numbers, then use `as.list()` to convert that to a list
n <- as.list(runif(10))

# Use `lapply()` to apply the `round()` function to each number, rounding it to 
# the nearest 0.1 (one decimal place)
lapply(n, 0.1, round)

# Create a variable 'sentence' that contains a sentence of text (something 
# longish). Make the sentence lowercase; you can use a function to help.
sentence <- "They sat in a heavy flat-bottomed boat, each holding a long, crooked rod in his hands and eagerly waiting for a bite."

# Use the `strsplit()` function to split the sentence into a vector of letters.
# Hint: split on `""` to split every character
# Note: this will return a _list_ with 1 element (which is the vector of letters)
strsplit(sentence, "")

# Extract the vector of letters from the resulting list


# Use the `unique()` function to get a vector of unique letters
unique(sentence, incomparable = FALSE, MARGIN = 1)

# Define a function `count_occurrences` that takes in two parameters: a letter 
# and a vector of letters. The function should return how many times that letter
# occurs in the provided vector.
# Hint: use a filter operation!
count_occurrences <- func(a, b) {
    for (j in 1:length(b)) {
        if (b[j] == a){
            count <- count + 1
        }
    }
}

# Call your `count_occurrences()` function to see how many times the letter 'e'
# is in your sentence.
count_occurence(e, sentence)

# Use `sapply()` to apply your `count_occurrences()` function to each unique 
# letter in the vector to determine their frequencies.
# Convert the result into a list (using `as.list()`).


# Print the resulting list of frequencies

