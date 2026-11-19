# Shark and Awe Podcast Analytics

This project analyzes the growth of Shark and Awe, a shark conservation 
podcast launched in August 2025, using listener engagement data from 
Spotify for Creators. The analysis explores audience growth, platform 
distribution, and global listener geography across the podcast's history
since launch. Understanding these patterns provides insight into the reach
of shark conservation messaging and helps identify opportunities to expand
science communication efforts.

## Data sources

### `data/raw/engagement_daily.csv`
- **Title of the dataset:** Shark and Awe Podcast Daily Engagement Metrics
- **Source:** Spotify for Creators (<https://creators.spotify.com>)
- **Date of download or access:** September 29, 2026

### `data/raw/apps_platform.csv`
- **Title of the dataset:** Shark and Awe Podcast Listener Distribution by Streaming Platform
- **Source:** Spotify for Creators (<https://creators.spotify.com>)
- **Date of download or access:** September 29, 2026

### `data/raw/geolocation.csv`
- **Title of the dataset:** Shark and Awe Podcast Listener Distribution by Country
- **Source:** Spotify for Creators (<https://creators.spotify.com>)
- **Date of download or access:** November 7, 2026

## Repository structure and contents

- `data`: Contains the raw and processed data:
  - `data/raw/engagement_daily.csv`: Raw daily engagement metrics (consumption time, average consumption time, comments, followers) from August 15, 2025 to November 8, 2026
  - `data/raw/apps_platform.csv`: Raw listener distribution across streaming platforms (all-time, August 15, 2025 to November 8, 2026)
  - `data/raw/geolocation.csv`: Raw listener distribution by country (August 1, 2025 to August 1, 2026)
  - `data/processed/engagement_clean.rds`: Cleaned daily engagement data, produced by `scripts/01_processing/data_processing.R`
  - `data/processed/apps_clean.rds`: Cleaned platform distribution data, produced by `scripts/01_processing/data_processing.R`
- `scripts`: Contains all R scripts used in this project:
  - `scripts/01_processing/data_processing.R`: This file reads `data/raw/engagement_daily.csv` and `data/raw/apps_platform.csv`, cleans and transforms the data, and exports `data/processed/engagement_clean.rds` and `data/processed/apps_clean.rds`
  - `scripts/02_content/exploratory_data_visualization.R`: This file reads `data/processed/engagement_clean.rds` and `data/processed/apps_clean.rds`, generates exploratory visualizations, and exports `figures/follower_growth.png`, `figures/engagement_metrics.png`, and `figures/platform_distribution.png`
  - `scripts/02_content/spatial_data_visualization.R`: This file reads `data/raw/geolocation.csv`, generates a world map of podcast listener distribution, and exports `results/img/shark_and_awe_listener_map.png`
- `figures`: Contains exploratory data visualizations:
  - `figures/follower_growth.png`: Line chart of daily follower growth over time, produced by `scripts/02_content/exploratory_data_visualization.R`
  - `figures/engagement_metrics.png`: Line chart of daily comments and consumption time, produced by `scripts/02_content/exploratory_data_visualization.R`
  - `figures/platform_distribution.png`: Bar chart of listener distribution by streaming platform, produced by `scripts/02_content/exploratory_data_visualization.R`
- `results`: Contains spatial data visualizations:
  - `results/img/shark_and_awe_listener_map.png`: World map of podcast listener distribution across 46 countries during the first year of release, produced by `scripts/02_content/spatial_data_visualization.R`
