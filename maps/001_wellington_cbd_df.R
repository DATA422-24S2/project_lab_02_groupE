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


#Ensure shapefile columns have correct types
sa2_ta$SA2_Code <- as.integer(sa2_ta$SA2_Code)
shapefile_data$SA22023_V1 <- as.integer(shapefile_data$SA22023_V1)

#Filter for Wellington Central specifically (SA22023_V1 = 251400)
wellington_data <- sa2_ta %>%
  filter(Area_Name == "Wellington Central")

#merging csv file with shapefile with SA2 Code
wellington_map_data <- right_join(shapefile_data, wellington_data, by = c("SA22023_V1" = "SA2_Code"))


# View the filtered Wellington Central data
#View(wellington_central_data)

#Plot Wellington Central using ggplot2
ggplot(data = wellington_map_data) +
  geom_sf() +
  geom_sf_text(aes(label = SA22023_V1), size = 3, color = "black") +
  ggtitle("Map of Wellington Central (251400)") +
  theme_void()
