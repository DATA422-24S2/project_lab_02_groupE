#installing necessary packages
library(leaflet)
library("sf")
library("ggplot2")
library("dplyr")
library("readr")

#reading the csv file containing necessary data
sa2_ta <- read_csv('./data/clean_sa2_ta_concord_data.csv')

#Import the shapefile
read_shapefile <- './data/statistical-area-2-2023-generalised.shp'
shapefile_data <- st_read(read_shapefile)


# Ensure consistent data types for the SA2 columns. Will be used later to create ggplot map
sa2_ta$SA2_Code <- as.integer(sa2_ta$SA2_Code)
shapefile_data$SA22023_V1 <- as.integer(shapefile_data$SA22023_V1)


#Area names for chch cbd
chch_cbd_names <- c("Christchurch Central", "Christchurch Central-West", "Christchurch Central-East",
                    "Christchurch Central-North", "Christchurch Central-South", "Hagley Park")
#filtering to find chch cbd
christchurch_data <- sa2_ta %>%
  filter(Area_Name %in% chch_cbd_names)

#merging filtered data with shapefile with SA2 Code
merge_map_data <- right_join(shapefile_data, christchurch_data, by = c("SA22023_V1" = "SA2_Code"))


# Plotting the christchurch region
chch_region <- ggplot(data = merge_map_data) +
  geom_sf() +
  geom_sf_text(aes(label = SA22023_V1), size = 3, color = "black") +
  ggtitle("Map of Christchurch CBD") +
  theme_void()
#chch_region
