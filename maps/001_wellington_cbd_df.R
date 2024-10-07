# Load required libraries
library(leaflet)
library(sf)
library(ggplot2)
library(dplyr)

source("./test/002_clean_files_BD.R")

#Import the shapefile
read_shapefile <- './data/statistical-area-2-2023-generalised.shp'
shapefile_data <- st_read(read_shapefile)
View(shapefile_data)

#Ensure shapefile columns have correct types
shapefile_data$SA22023_V1 <- as.character(shapefile_data$SA22023_V1)
sa2_2023_data_2$`Classification report` <- as.character(sa2_2023_data_2$`Classification report`)

#Merge shapefile data with concord data (left join)
merge_map_data <- left_join(shapefile_data, sa2_2023_data_2, by = c("SA22023_V1" = "Classification report"))
View(merge_map_data)

#Filter for Wellington Central specifically (SA22023_V1 = 251400)
wellington_central_data <- merge_map_data %>%
  filter(...2 == "Wellington Central,")

# View the filtered Wellington Central data
View(wellington_central_data)

#Plot Wellington Central using ggplot2
ggplot(data = wellington_central_data) +
  geom_sf() +
  geom_sf_text(aes(label = SA22023_V1), size = 3, color = "black") +
  ggtitle("Map of Wellington Central (251400)") +
  theme_void()
