#installing necessary packages
library(leaflet)
library("sf")
library("ggplot2")
library("dplyr")

sa2_ta <- read_csv('./data/clean_sa2_ta_concord_data.csv')
# Ensure consistent data types for the SA2 columns. Will be used later to create ggplot map
sa2_ta$SA2_Code <- as.character(sa2_ta$SA2_Code)
shapefile_data$SA22023_V1 <- as.character(shapefile_data$SA22023_V1)

#merging csv file with shapefile with SA2 Code
merge_map_data <- left_join(shapefile_data, sa2_ta, by = c("SA22023_V1" = "SA2_Code"))

#

christchurch_data <- merge_map_data %>%
  filter()