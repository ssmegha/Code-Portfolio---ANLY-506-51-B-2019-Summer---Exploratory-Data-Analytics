---
title: "Week 2"
author: "Megha S"
date: "May 14, 2019"

## Data Type and Data Format ##
# Basic data types are Numeric, Integer, Complex, Logical, Character
# Numerics - Decimal values are called numerics
x = 10.5       # assign a decimal value
x              # print the value of x 
class(x)       # print the class name of x
k = 1 
k              # print the value of k 
class(k)       # print the class name of k 

# USing the is.integer function to check if k is an integer or not
is.integer(k)  # is k an integer? 

# Complex -  pure imaginary value i
z = 1 + 2i     # create a complex number 
z              # print the value of z 
class(z)       # print the class name of z 

sqrt(-1)       # square root of −1
# It gives an error as −1 is not a complex value

# Logical - created via comparison between variables
x = 1; y = 2   # sample values 
z = x > y      # is x larger than y? 
z              # print the logical value
class(z)       # print the class name of z 

# Standard logical operations are "&" (and), "|" (or), and "!" (negation)
u = TRUE; v = FALSE 
u & v          # u AND v
u | v          # u OR v 
!u             # negation of u 

# Character - It is used to represent string values in R
x = as.character(3.14) 
x              # print the character string
class(x)       # print the class name of x

# Two character values can be concatenated with the paste function
fname = "Joe"; lname ="Smith"
paste(fname, lname) 

# Creating a readable string with the sprintf function
sprintf("%s has %d dollars", "Sam", 100) 

# To extract a substring, we apply the substr function
substr("Mary has a little lamb.", start=3, stop=12) 

# And to replace the first occurrence of the word "little" by another word "big" in the string, we apply the sub function
sub("little", "big", "Mary has a little lamb.")



