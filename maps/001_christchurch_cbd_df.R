#installing necessary packages
library(leaflet)
library("sf")
library("ggplot2")
library("dplyr")
library("readr")

#reading the csv file containing necessary data
sa2_ta <- read_csv('./data/clean_sa2_ta_concord_data.csv')


# Ensure consistent data types for the SA2 columns. Will be used later to create ggplot map
sa2_ta$SA2_Code <- as.integer(sa2_ta$SA2_Code)


#Area names for chch cbd
chch_cbd_names <- c("Christchurch Central", "Christchurch Central-West", "Christchurch Central-East",
                    "Christchurch Central-North", "Christchurch Central-South", "Hagley Park")
#filtering to find chch cbd
christchurch_cbd_sa2_data <- sa2_ta %>%
  filter(Area_Name %in% chch_cbd_names)

#filtering cbd data to get only sa2 codes
christchurch_cbd_sa2_codes <- christchurch_cbd_sa2_data$SA2_Code
  


