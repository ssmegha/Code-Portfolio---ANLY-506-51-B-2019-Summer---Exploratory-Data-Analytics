---
title: "Week 4"
author: "Megha S"
date: "May 28, 2019"

## Data Structures ##
# There are two types of vectors:
# Atomic vectors, of which there are six types: logical, integer, double, character, complex, and raw. Integer and double vectors are collectively known as numeric vectors
# Lists, which are sometimes called recursive vectors because lists can contain other lists

# Vector basics
# Using type, which you can determine with typeof()
typeof(letters)
typeof(1:10)

# Using function length() to determine length
x <- list("a", "b", 1:10)
length(x)

# Logical vectors - can be used along with comparison operators c()
# They can take only three possible values: FALSE, TRUE, and NA
1:10 %% 3 == 0
c(TRUE, TRUE, FALSE, NA)

# Numeric vectors - Integer and double vectors are known collectively as numeric vectors
# Numbers are doubles by default. To make an integer, we place an L after the number
typeof(1)
typeof(1L)
1.5L

# Doubles - This represent floating point numbers that can not always be precisely represented with a fixed amount of memory
# Checking square of the square root of two
x <- sqrt(2) ^ 2
x
x - 2

# Most floating point numbers have some approximation error. Instead of using == , if we use dplyr::near(), it allows for some numerical tolerance

# Integers have one special value: NA, while doubles have four: NA, NaN, Inf and -Inf. All three special values NaN, Inf and -Inf can arise during division
c(-1, 0, 1) / 0
 
# Character vectors - they are most complex type of atomic vector
# Each unique string is only stored in memory once, this reduces the amount of memory needed by duplicated strings
x <- "This is a reasonably long string."
pryr::object_size(x)

y <- rep(x, 1000)
pryr::object_size(y)

# Missing values for atomic vectors
NA            # logical
NA_integer_   # integer
NA_real_      # double
NA_character_ # character

# Coercion - Explicit & Implicit 
x <- sample(20, 100, replace = TRUE)
y <- x > 10
sum(y)  # how many are greater than 10?
mean(y) # what proportion are greater than 10?
# In this case TRUE is converted to 1 and FALSE converted to 0

# Scalars and vector recycling
sample(10) + 100
runif(10) > 0.5
1:10 + 1:2
1:10 + 1:3

# Vectorised functions in tidyverse will throw errors when you recycle anything other than a scalar
# To recycle, we use the function rep()
tibble(x = 1:4, y = 1:2)
tibble(x = 1:4, y = rep(1:2, 2))
tibble(x = 1:4, y = rep(1:2, each = 2))

# Naming vectors - Most useful for subsetting
# vectors can be named using c()
c(x = 1, y = 2, z = 4)
set_names(1:3, c("a", "b", "c"))

# Subsetting #
# Subsetting with positive integers 
x <- c("one", "two", "three", "four", "five")
x[c(3, 2, 5)]

x[c(1, 1, 5, 5, 5, 2)] # output longer than input

x[c(-1, -3, -5)] # Negative values drop the elements

x[c(1, -1)] # Error mixing positive and negative values

x[0] # error message mentions subsetting with zero, returns no values

## Recursive vectors (lists) ##
# List contains other lists representing hierarchical or tree-like structures
x <- list(1, 2, 3)
x

# Creating structure
str(x)
x_named <- list(a = 1, b = 2, c = 3)
str(x_named)
y <- list("a", 1L, 1.5, TRUE)
str(y)

# List containing other lists
z <- list(list(1, 2), list(3, 4))
str(z)

# Visualising lists
x1 <- list(c(1, 2), c(3, 4))
x2 <- list(list(1, 2), list(3, 4))
x3 <- list(1, list(2, list(3)))

# Subsetting
# Subsetting a list
a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))
str(a[1:2])
str(a[4])

# Subsetting a logical, integer, or character vector
str(a[[1]])
str(a[[4]])

# Extracting names elements in a list
a$a

# Attributes - named list of vectors
x <- 1:10
attr(x, "greeting")
attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
attributes(x)

# Factors - represent categorical data 
x <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))
typeof(x)
attributes(x)

# Dates and date-times - numeric vectors
x <- as.Date("1971-01-01")
unclass(x)
typeof(x)
attributes(x)

# Class POSIXct that represent the number of seconds 
x <- lubridate::ymd_hm("1970-01-01 01:00")
unclass(x)
typeof(x)
attributes(x)

# Tibbles - augmented lists
tb <- tibble::tibble(x = 1:5, y = 5:1)
typeof(tb)
attributes(tb)
# The difference between a tibble and a list is that all the elements of a data frame must be vectors with the same length

df <- data.frame(x = 1:5, y = 5:1)
typeof(df)
attributes(df)
# tibble includes “data.frame”
