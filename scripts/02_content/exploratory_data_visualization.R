################################################################################
# Exploratory Data Visualization Script - Assignment #2
################################################################################

# Candace Drabeck
# cnd88@miami.edu
# October 11, 2026

# Description:

## This script reads the cleaned Spotify podcast data,
## generates exploratory visualizations using ggplot2,
## and exports the plots as .png files.
################################################################################

## Step 1: Load the required packages.

library(tidyverse)

## Step 2: Read the cleaned data from both .rds files
apps_clean <- read_rds("data/processed/apps_clean.rds")
engagement_clean <- read_rds("data/processed/engagement_clean.rds")

## Step 3: PLOT THE DATA FOR VISUALIZATION ###################################

# Plot 1: Follower growth over time
follower_growth <- ggplot(engagement_clean,
                          mapping = aes(x = date,
                                        y = followers)) +
  geom_line(color = "steelblue", linewidth = 1) +
  labs(
    title = "Shark and Awe Podcast: Follower Growth Over Time",
    subtitle = "Daily follower count since launch",
    x = "Date",
    y = "Followers",
    caption = "Source: Spotify for Creators"
  ) +
  theme_minimal()

# Save Plot 1 as .png using ggsave() 
ggsave("figures/follower_growth.png",
       follower_growth,
       width = 8,
       height = 5,
       dpi = 300)


# Plot 2: Reshape engagement data ###########################################
engagement_long <- engagement_clean |>
  select(date,
         comments,
         consumption_time_hours) |>
  rename(Comments = comments,
    `Consumption Time (hours)` = consumption_time_hours) |>
  pivot_longer(cols = c(Comments,
                        `Consumption Time (hours)`),
    names_to = "metric",
    values_to = "value")


# Create a line chart with a coded legend
engagement_metrics <- ggplot(engagement_long,
                             mapping = aes(x = date,
                                           y = value,
                                           color = metric)) +
  geom_line(linewidth = 1) +
  scale_color_manual(values = c("darkgreen", "steelblue")) +
  labs(title = "Shark and Awe Podcast: Daily Engagement Metrics",
    subtitle = "Comments and consumption time per day since launch",
    x = "Date",
    y = "Daily Value",
    color = "Engagement Metric",
    caption = "Source: Spotify for Creators") +
  theme_minimal()

# Save Plot 2 as .png using ggsave()
ggsave("figures/engagement_metrics.png",
       engagement_metrics,
       width = 8,
       height = 5,
       dpi = 300)


# Plot 3: Platform distribution bar chart
platform_distribution <- ggplot(data = apps_clean,
                                mapping = aes(x = app,
                                              y = percentage,
                                              fill = app)) +
  geom_col() +
  scale_fill_manual(values = c("darkgreen",
                               "darkgreen",
                               "darkgreen",
                               "darkgreen",
                               "darkgreen",
                               "steelblue",
                               "darkgreen")) +
  labs(title = "Shark and Awe Podcast: Listener Distribution by Platform",
    x = "Platform",
    y = "Percentage of Listeners",
    fill = "Platform",
    caption = "Source: Spotify for Creators") +
  coord_flip() +
  theme_minimal() +
  theme(legend.position = "none")

# Save Plot 3 as .png using ggsave()
ggsave("figures/platform_distribution.png",
       platform_distribution,
       width = 8,
       height = 5,
       dpi = 300)

