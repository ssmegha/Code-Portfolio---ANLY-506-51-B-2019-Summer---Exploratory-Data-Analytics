---
title: "Week 3"
author: "Megha S"
date: "May 21, 2019"

## Data Workflow ##
# Exploratory Data Analysis
# Read in your data
library(readr)
ozone <- read_csv("data/hourly_44201_2014.csv", 
                  +                   col_types = "ccccinnccccccncnncccccc")
names(ozone) <- make.names(names(ozone))

# Check the packaging
nrow(ozone)
ncol(ozone)

# Running structuee str()
str(ozone)

# Look at the top and the bottom of your data
head(ozone[, c(6:7, 10)])
tail(ozone[, c(6:7, 10)])

# Check your “n”s
table(ozone$Time.Local)
library(dplyr)
filter(ozone, Time.Local == "13:14") %>% 
  +         select(State.Name, County.Name, Date.Local, 
                   +                Time.Local, Sample.Measurement)
# A tibble: 2 × 5

# Measurements taken on a particular date
filter(ozone, State.Code == "36" 
       +        County.Code == "033" 
       +        Date.Local == "2014-09-30") %>%
  +         select(Date.Local, Time.Local, 
                   +                Sample.Measurement) %>% 
  +         as.data.frame
select(ozone, State.Name) %>% unique %>% nrow

# Validate with at least one external data source
# Hourly measurements of ozone
summary(ozone$Sample.Measurement)

# More detail on the distribution by looking at deciles of the data
quantile(ozone$Sample.Measurement, seq(0, 1, 0.1))

# Try the easy solution first
# To identify each county we will use a combination of the State.Name and the County.Name variables
ranking <- group_by(ozone, State.Name, County.Name) %>%
  +         summarize(ozone = mean(Sample.Measurement)) %>%
  +         as.data.frame %>%
  +         arrange(desc(ozone))

# Using the header function to look at the top 10 countries in this ranking
head(ranking, 10)

# Using the tail function to look at the 10 lowest counties too
tail(ranking, 10)

# Having a look at one of the higest level counties
filter(ozone, State.Name == "California" & County.Name == "Mariposa") %>% nrow

# Need to convert the date variable into a Date class
ozone <- mutate(ozone, Date.Local = as.Date(Date.Local))

# Spliting the data by month to look at the average hourly levels
filter(ozone, State.Name == "California" & County.Name == "Mariposa") %>%
  +         mutate(month = factor(months(Date.Local), levels = month.name)) %>%
  +         group_by(month) %>%
  +         summarize(ozone = mean(Sample.Measurement))
# A tibble: 10 × 2

# Taking a look at one of the lowest level counties, Caddo County, Oklahoma
filter(ozone, State.Name == "Oklahoma" & County.Name == "Caddo") %>% nrow
filter(ozone, State.Name == "Oklahoma" & County.Name == "Caddo") %>%
  +         mutate(month = factor(months(Date.Local), levels = month.name)) %>%
  +         group_by(month) %>%
  +         summarize(ozone = mean(Sample.Measurement))
# A tibble: 9 × 2

# Using the resampled indices to create a new dataset, ozone2, that shares many of the same qualities as the original but is randomly perturbed
set.seed(10234)
N <- nrow(ozone)
idx <- sample(N, N, replace = TRUE)
ozone2 <- ozone[idx, ]

# Reconstructing our rankings of the counties based on this resampled data
ranking2 <- group_by(ozone2, State.Name, County.Name) %>%
  +         summarize(ozone = mean(Sample.Measurement)) %>%
  +         as.data.frame %>%
  +         arrange(desc(ozone))

# Comparing the top 10 counties from our original ranking and the top 10 counties from our ranking based on the resampled data
cbind(head(ranking, 10),
      +       head(ranking2, 10))

# Checking the bottom of the list to see if there were any major changes
cbind(tail(ranking, 10),
      +       tail(ranking2, 10))
