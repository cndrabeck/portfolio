################################################################################
# Data processing R script - Assignment #2
################################################################################

## Shark and Awe Podcast Analytics
## Candace Drabeck
## cnd88@miami.edu
## October 11, 2026

# Description:

## This script reads raw data exported from Spotify for Creators.
## It also cleans, transforms, and exports processed data as
## .rds files for visualization.
################################################################################

## Step 1: Load the required packages.

library(tidyverse)
library(janitor)

## Step 2: Read in the first data file (apps_platform.csv) and
## assign a designator (name) to it (create a new OBJECT).
#### (This task accomplishes reading raw data)

apps_raw <- read_csv("data/raw/apps_platform.csv")
#### use read_csv because the function is literally reading the csv file.
#### The green text displays the RELATIVE path to the selected file.

## 1. Review, then clean up the FIRST DATA SET .
# Clean the raw apps data: Select useful columns, standardize names, 
# round percentages, and sort from highest to lowest (descending order)
apps_clean <- apps_raw |>
  select(App, Percentage) |>   #Keep app name and percentage;remove 3 empty columns (3, 4, 'All-time...')
  janitor::clean_names() |>   #Standardize column names (lowercase, snake_case)
  mutate(percentage = round(percentage, 1)) |>  #Round percentages to 1 decimal place
  arrange(desc(percentage)) #Sort from highest to lowest percentage (descending)


## 2. Export cleaned data 
write_rds(apps_clean, "data/processed/apps_clean.rds") #Save into R's standard format


## Step 3: Read in [RAW] engagement data (second data file) - daily metrics 
## from podcast launch to present
engagement_raw <- read_csv("data/raw/engagement_daily.csv")

# Clean the RAW engagement data: select useful columns, standardize names,
# convert dates, remove the incomplete row, and sort chronologically
engagement_clean <- engagement_raw |>
  select(
    Date, 
    `Consumption time (hours)`, 
    `Average consumption time (hours)`, 
    Comments, 
    Followers) |>    # Keep only real data columns; drop 2 empty columns
  janitor::clean_names() |>    # Standardize column names into lowercase & snake_case
  mutate(date = mdy(date)) |>    # Convert date from text to actual date format using lubridate package
  drop_na() |>    # Remove rows with any NA values (day with no data)
  arrange(date)

# Export cleaned engagement data as .rds (R's standard format)
write_rds(engagement_clean, "data/processed/engagement_clean.rds")

