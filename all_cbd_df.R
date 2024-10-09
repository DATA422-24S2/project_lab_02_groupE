#installing necessary readr file for read_csv function
library("readr")
library(leaflet)
library("sf")
library("ggplot2")
library("dplyr")


source("./maps/001_christchurch_cbd_df.R")
source("./maps/001_auckland_cbd_df.R")
source("./maps/001_wellington_cbd_df.R")

View(wellington_data)
View(christchurch_data)
View(auckland_cbd_sa2_data)

data$TA_Code <- as.integer(data$TA_Code)
auckland_cbd_sa2_data$TA_Code <- as.integer(auckland_cbd_sa2_data$TA_Code)
auckland_cbd_sa2_data$SA2_Code <- as.integer(auckland_cbd_sa2_data$SA2_Code)

#all_cbd_df <- st_join(christchurch_data, wellington_central_data, by = c("SA22023_V1" = "SA2_Code")) 
combined_chch_well_data <- bind_rows(christchurch_data, wellington_data)

#converting TA_codes into integers
combined_chch_well_data$TA_Code <- as.integer(combined_chch_well_data$TA_Code)
auckland_cbd_sa2_data$TA_Code <- as.integer(auckland_cbd_sa2_data$TA_Code)

#combined data for all cbds
combined_data <- bind_rows(combined_chch_well_data, auckland_cbd_sa2_data)

