################################################################################
# Assignment 3: Visualizing spatial data
################################################################################
#
# Candace Drabeck
# cnd88@miami.edu
# November 15, 2026
#
# Working with spatial data to produce a map of my “study site”. This script
# reads cleaned podcast listener data and creates a world map showing the
# geographic distribution of listeners across the podcast's first year
# (August 1, 2025 - August 1, 2026).
# The map is then exported as a .png file.
#
################################################################################
## Install packages -----------------------------------------------------------
# (install.packages("rnaturalearthdata") in Console)

## Load packages --------------------------------------------------------------
library(tidyverse)         
library(sf)                #Spatial data
library(rnaturalearth)     #World map data source
library(rnaturalearthdata) #Create visual polygons
library(ggspatial)         #Map creation and visualization

## Load raw data ##
geo_raw <- read_csv("data/raw/geolocation.csv")

## Clean data -----------------------------------------------------------------
geo_clean <- geo_raw |>           #Create a new object containing the cleaned data
  select(Geo, Percentage) |>      #Keep my selected columns, removes the others
  rename(country = Geo,           #Change "Geo" to 'country'
         percentage = Percentage) |>  #Change "Percentage" to 'percentage'
  drop_na() |>                        #Remove rows with missing values
                                  #Standardize US name to match world data
  mutate(country = case_when(country == "United States" ~ "United States of America",
    TRUE ~ country))                   #Keep all other country names unchanged

## Load world map data --------------------------------------------------------
world <- ne_countries(scale = "medium",   #Scaled up from default 'small'
                      returnclass = "sf") #Ensure compatibility with geom_sf()

## Join podcast data to world map ---------------------------------------------
world_podcast_data <- world |>
  left_join(geo_clean, by = c("admin" = "country")) #Combine datasets
                        #Countries without listeners will have 'NA' percentage

## Filter to show only countries with listeners _------------------------------
world_podcast_only <- world_podcast_data |>
  filter(!is.na(percentage))

## Build a world map using podcast data ---------------------------------------
map <- ggplot() +      
  geom_sf(data = world,           #Base layer (shows all countries for context)
          fill = "gray90",        #Countries with no listeners (0%)
          color = "black",        #Outlines to show borders
          linewidth = 0.2) +      #Outline thickness
  geom_sf(data = world_podcast_only, #Countries with listeners
          aes(fill = percentage),  #Fill 'color' designated by listener percentage
          color = "black",
          linewidth = 0.2) +
  scale_fill_viridis_c(option = "plasma",
                       trans = "log10",      #Log transformation for wide listener range
                       limits = c(0.05, 100), #Set color scale range from 0.05 to 100
                       breaks = c(0.1, 1, 10, 100),  #Values shown on the legend
                       labels = scales::label_number(), #Format as regular numbers
                       name = "Listeners (%)") +
  guides(fill = guide_colorbar(barheight = unit(5, "cm"))) + #Make color bar taller
  theme_bw() +
  theme(legend.title = element_text(margin = margin(b = 10))) + #Add space between legend title and values
  labs(title = "Shark and Awe podcast listeners by country",
       subtitle = "First year of podcast (August 2025 - August 2026)",
       x = "Longitude",
       y = "Latitude",
       caption = "Data source: Spotify for Creators") +
  annotation_scale(location = "br",
                   width_hint = 0.3,               #Control length of scale bar
                   pad_y = unit(0.2, "cm")) +      #Padding from bottom edge
  annotation_north_arrow(location = "bl",
                         which_north = "true",           #True North
                         height = unit(1.5, "cm"),
                         width = unit(1.5, "cm"),
                         pad_x = unit(0.3, "cm"),       #Padding from left edge
                         pad_y = unit(1.0, "cm"),       #Padding from bottom
                         style = north_arrow_fancy_orienteering())       #Style

## Export map in .png format --------------------------------------------------
ggsave(filename = "results/img/shark_and_awe_listener_map.png",
       plot = map,
       width = 10,
       height = 6,
       units = "in",
       dpi = 300)

map




