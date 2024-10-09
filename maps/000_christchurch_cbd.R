library(leaflet)

####The purpose of this code is to create maps for each of the CBD's using leaflet

# Define the updated, more precise Christchurch CBD boundary including Hagley Park
chch_cbd_hagley_coords <- list(
  c(172.6130, -43.5243),  # North-West corner (Harper Ave and Deans Ave)
  c(172.6258, -43.5205),
  c(172.6515, -43.5205),  # North-East corner (Bealey Ave and Fitzgerald Ave)
  c(172.6515, -43.5400),  # South-East corner (Moorhouse Ave and Fitzgerald Ave)
  c(172.6115, -43.5400),  # South-West corner (Deans Ave and Moorhouse Ave)
  c(172.6115, -43.5243)   # Closing point back to North-West
)


# Create a leaflet map and plot the Christchurch CBD boundary
leaflet() %>%
  addTiles() %>%
  addPolygons(
    lng = sapply(chch_cbd_hagley_coords, function(x) x[1]),
    lat = sapply(chch_cbd_hagley_coords, function(x) x[2]),
    color = "green",  # Border color
    fillColor = "lightgreen",  # Fill color
    fillOpacity = 0.5,  # Opacity of the polygon fill
    weight = 2,  # Thickness of the border line
    popup = "Christchurch CBD"
  ) %>%
  setView(lng = 172.6300, lat = -43.5290, zoom = 13)


####The purpose of this code is to use ggplot to show a map of the necessary
####SA2 regions.

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
chch_region
