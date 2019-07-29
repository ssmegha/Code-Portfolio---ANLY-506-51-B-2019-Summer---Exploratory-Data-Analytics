---
title: "Week 5"
author: "Megha S"
date: "June 04, 2019"

## Data Wranling ##
# Missing Values and Imputation
# tidyr is a member of the core tidyverse package, we’ll focus on tidyr, a package that provides a bunch of tools to help tidy up your messy datasets
# Loading package tidyverse
library(tidyverse)

# Tidy data - Loading the same data in 4 different ways - each dataset organises the values in a different way
table1
table2
table3
# Spread across two tibbles
table4a  # cases
table4b  # population

# The tidy dataset, will be much easier to work with inside the tidyverse
# Other packages like dplyr and ggplot2 in the tidyverse are designed to work with tidy data

# Compute rate per 10,000
table1 %>% 
  mutate(rate = cases / population * 10000)

# Compute cases per year
table1 %>% 
  count(year, wt = cases)

# Visualising changes over time - usng package ggplot2
library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))

# Spreading and Gathering
# Two most important functions in tidyr are gather() and spread()
# Gathering - A common problem is a dataset where some of the column names are not names of variables, but values of a variable
table4a
# The dataset is untidy, To tidy this dataset, we need to gather those columns into a new pair of variables
# Together those parameters generate the call to gather()
table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")

# We can use gather() to tidy table4b in a similar fashion. The only difference is the variable stored in the cell values
table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")

# To combine the tidied versions of table4a and table4b into a single tibble, we need to use dplyr::left_join()
tidy4a <- table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
tidy4b <- table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
left_join(tidy4a, tidy4b)

# Spreading - It is the opposite of gathering
# We use it when an observation is scattered accross multiple rows
# We observe in table2 that each observation is spread across two rows
table2

# To tidy up, we will use spread() as below
table2 %>%
  spread(key = type, value = count)

# Separate
# separate() pulls apart one column into multiple columns, by splitting wherever a separator character appears
table3 %>% 
  separate(rate, into = c("cases", "population"))
# separate() will split values wherever it sees a non-alphanumeric character 
# To use a specific character to separate a column, we can pass the character to the sep argument of separate()
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")

# We see that cases and population are character columns. This is the default behaviour in separate(): it leaves the type of the column as is.
table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)

# Using this to separate the last two digits of each year, making the data less tidy
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

# Unite - It is the inverse of separate()
# It combines multiple columns into a single column
# Using unite() to rejoin the century and year columns that we created 
# unite() takes a data frame, the name of the new variable to create, and a set of columns to combine, again specified in dplyr::select() style
table5 %>% 
  unite(new, century, year)

# Using the sep argument
table5 %>% 
  unite(new, century, year, sep = "")

## Missing values ##
# We can use mssing values Explicitly (flagged with NA) or Implicitly (not present in the data)
# Checking missing values in the dataset
stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)
# There are two missing values in this dataset

# Making the implicit missing value explicit by putting years in the columns
stocks %>% 
  spread(year, return)

# Setting na.rm = TRUE in gather() to turn explicit missing values implicit
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)

# Making missing values explicit in tidy data is complete()
# complete() takes a set of columns, and finds all unique combinations
# Sometimes missing values indicate that the previous value should be carried forward
treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)

# We can use fill() to fill the missing values
treatment %>% 
  fill(person)






