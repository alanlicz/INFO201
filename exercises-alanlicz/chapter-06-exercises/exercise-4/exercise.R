# Exercise 4: functions and conditionals

# Define a function `is_twice_as_long` that takes in two character strings, and 
# returns whether or not (e.g., a boolean) the length of one argument is greater
# than or equal to twice the length of the other.
# Hint: compare the length difference to the length of the smaller string
is_twice_as_long <- function(a, b) {
	if (nchar(a)-nchar(b) < 0) {
		return nchar(b) > 2*nchar(a)
	} else
		return nchar(a) > 2*nchar(b)
	}
}

# Call your `is_twice_as_long` function by passing it different length strings
# to confirm that it works. Make sure to check when _either_ argument is twice
# as long, as well as when neither are!
is_twice_long(10, 30)


# Define a function `describe_difference` that takes in two strings. The
# function should return one of the following sentences as appropriate
#   "Your first string is longer by N characters"
#   "Your second string is longer by N characters"
#   "Your strings are the same length!"
describe_difference <- funtion(a, b) {
	if (nchar(a)-nchar(b) > 0) {
		print(paste("Your first string is longer by", nchar(a)-nchar(b), "characters"))
	} else if (nchar(a) - nchar(b) < 0) {
		print(paste("Your second string is longer by", nchar(b)-nchar(a), "characters"))
	} else {
		print("Your string are the same length!")
	}
}

# Call your `describe_difference` function by passing it different length strings
# to confirm that it works. Make sure to check all 3 conditions1

