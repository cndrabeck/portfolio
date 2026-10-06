################################################################################
#  Scaling Up Your Data Visualization 
################################################################################
#
# Candace Drabeck
# cnd88@miami.edu
# Week 8 / Class 1 / Oct 6, 2026
#
# Scaling Up Your Data Visualization
#
################################################################################

# SET UP ############################################################

## Load Packages
library(EVR628tools)
library(tidyverse)

## Load data ########################################################
data("data_lionfish")
data("data_mhw_ts")
data("data_mhw_events")

## Processing #######################################################

## Build plot for lionfish length vs weight -------------------------------

ggplot(data = data_lionfish,
       mapping = aes(x = total_length_mm,
                     y = total_weight_gr)) +
  geom_smooth(color = "black",          ## Change aesthetic of the line.
              linetype = "dashed") +
  geom_vline(xintercept = c(100, 200), linetype = "dashed") +
  geom_point(aes(color = size_class)) + ## Change colors
  scale_color_manual(values = palette_UM(3)) +
  labs(x = "Total length (mm)",
       y = "Total weight (gr)",
       color = "Size class") +
  theme_bw() +
  theme(legend.position = "inside",
        legend.position.inside = c(0, 1),
        legend.justification.inside = c(0, 1),
        legend.background = element_rect(color = "blue", fill = "transparent"))


## Build a time series figure of MHWs (Marine Heatwaves)

ggplot(data = data_mhw_ts,
       mapping = aes(x = date,       ## 'time' = DATE
                     y = temp)) +
  geom_line(aes(y = temp)) +
  geom_line(aes(y = seas), color = "blue") +
  geom_line(aes(y = thresh), color = "red") +
  labs(x = "Date",
       y = "Temperature (*C)") +
  theme_bw()

data_mhw_ts |> 
  pivot_longer(cols = c(2, 3, 4)) |> 
  ggplot(aes(x = date, y = value, color = name)) +
  geom_line() +
  scale_color_manual(values = c("temp" = "black",
                                "seas" = "blue",
                                "thresh" = "red"))
                                
## Build MHW Event lollipop plot ############################################
### Lollipop plot (often used to represent marine heatwaves) ################
## data_mhw_events

ggplot(data = data_mhw_events,
       mapping = aes(x = date_peak,
                     y = intensity_max)) +
  geom_point() +                               ## First plot the points
  geom_linerange(aes(ymin = 0,
                     ymax = intensity_max))  ## Then connect the vertical lines

## Export ##########################################################

## The final step ---------------------------------------------------------





















