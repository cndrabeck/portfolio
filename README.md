# Shark and Awe Podcast Analytics

## Project Objective

This project analyzes the growth of Shark and Awe, a shark conservation 
podcast launched in August 2025, using listener engagement data from 
Spotify for Creators. The analysis explores audience growth and platform 
distribution across the podcast's history since launch. Understanding 
these patterns provides insight into the reach of shark conservation 
messaging and helps identify opportunities to expand science 
communication efforts.

## Repository Contents

### Raw Data

Raw data files are located in `data/raw/` and were exported from 
Spotify for Creators (https://creators.spotify.com):

- `engagement_daily.csv` — Daily engagement metrics (consumption time, 
  average consumption time, comments, followers) from August 15, 2025 
  to September 29, 2026
- `apps_platform.csv` — Listener distribution across streaming platforms 
  (all-time, August 15, 2025 to September 29, 2026)

### R Scripts

R scripts are located in `scripts/`:

- `scripts/01_processing/data_processing.R` — Reads raw CSV files, 
  cleans and transforms the data, exports processed data as .rds files
- `scripts/02_content/exploratory_data_visualization.R` — Reads 
  processed data and generates exploratory visualizations, exports 
  plots as .png files

### Processed Data

Cleaned data is located in `data/processed/`:

- `engagement_clean.rds` — Cleaned daily engagement data
- `apps_clean.rds` — Cleaned platform distribution data

### Figures

Exported figures are located in `figures/`:

- `follower_growth.png` — Follower growth over time
- `engagement_metrics.png` — Daily engagement metrics (comments and consumption time)
- `platform_distribution.png` — Listener distribution by streaming platform


