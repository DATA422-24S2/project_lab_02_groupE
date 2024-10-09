#installing necessary readr file for read_csv function
library("readr")
library(leaflet)
library("sf")
library("ggplot2")
library("dplyr")


source("./maps/001_christchurch_cbd_df.R")
source("./maps/001_auckland_cbd_df.R")
source("./maps/001_wellington_cbd_df.R")

View(wellington_central_data)
View(christchurch_data)
View()

#all_cbd_df <- st_join(christchurch_data, wellington_central_data, by = c("SA22023_V1" = "SA2_Code")) 
combined_data <- bind_rows(christchurch_data, wellington_central_data) 



