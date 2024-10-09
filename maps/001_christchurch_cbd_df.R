#installing necessary packages
library(leaflet)
library("sf")
library("ggplot2")
library("dplyr")

#reading the csv file containing necessary data
sa2_ta <- read_csv('./data/clean_sa2_ta_concord_data.csv')

#Import the shapefile
read_shapefile <- './data/statistical-area-2-2023-generalised.shp'
shapefile_data <- st_read(read_shapefile)


# Ensure consistent data types for the SA2 columns. Will be used later to create ggplot map
sa2_ta$SA2_Code <- as.character(sa2_ta$SA2_Code)
shapefile_data$SA22023_V1 <- as.character(shapefile_data$SA22023_V1)

#merging csv file with shapefile with SA2 Code
merge_map_data <- left_join(shapefile_data, sa2_ta, by = c("SA22023_V1" = "SA2_Code"))

#Area names for chch cbd
chch_cbd_names <- c("Christchurch Central", "Christchurch Central-West", "Christchurch Central-East",
                    "Christchurch Central-North", "Christchurch Central-South", "Hagley Park")

christchurch_data <- merge_map_data %>%
  filter(Area_Name %in% chch_cbd_names)

# Plotting the christchurch region
chch_region <- ggplot(data = christchurch_data) +
  geom_sf() +
  geom_sf_text(aes(label = SA22023_V1), size = 3, color = "black") +
  ggtitle("Map of Christchurch CBD") +
  theme_void()
chch_region
