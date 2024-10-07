#installing necessary packages
library(leaflet)
library("sf")
library("ggplot2")
library("dplyr")
#importing datafile to create map for SA2 Codes
read_shapefile <- './data/statistical-area-2-2023-generalised.shp'
shapefile_data <- st_read(read_shapefile)

#reading the file 
sa2_ta <- read_csv('./data/clean_sa2_ta_concord_data.csv')

# Ensure consistent data types for the SA2 columns. Will be used later to create ggplot map
sa2_ta$SA2_Code <- as.character(sa2_ta$SA2_Code)
shapefile_data$SA22023_V1 <- as.character(shapefile_data$SA22023_V1)

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
  setView(lng = 172.6300, lat = -43.520, zoom = 13)


#Christchurch cbd sa2 codes
chch_cbd_sa2 <- c("")