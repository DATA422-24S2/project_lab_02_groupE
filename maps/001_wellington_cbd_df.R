# Load required libraries
library(leaflet)
library(sf)
library(ggplot2)
library(dplyr)
library(readr)

#source("./test/002_clean_files_BD.R")
sa2_ta <- read_csv('./data/clean_sa2_ta_concord_data.csv')

#Import the shapefile
read_shapefile <- './data/statistical-area-2-2023-generalised.shp'
shapefile_data <- st_read(read_shapefile)
View(shapefile_data)

#Ensure shapefile columns have correct types
sa2_ta$SA2_Code <- as.character(sa2_ta$SA2_Code)
shapefile_data$SA22023_V1 <- as.character(shapefile_data$SA22023_V1)

#merging csv file with shapefile with SA2 Code
merge_map_data <- left_join(shapefile_data, sa2_ta, by = c("SA22023_V1" = "SA2_Code"))

#Filter for Wellington Central specifically (SA22023_V1 = 251400)
wellington_central_data <- merge_map_data %>%
  filter(Area_Name == "Wellington Central")

# View the filtered Wellington Central data
View(wellington_central_data)

#Plot Wellington Central using ggplot2
ggplot(data = wellington_central_data) +
  geom_sf() +
  geom_sf_text(aes(label = SA22023_V1), size = 3, color = "black") +
  ggtitle("Map of Wellington Central (251400)") +
  theme_void()
