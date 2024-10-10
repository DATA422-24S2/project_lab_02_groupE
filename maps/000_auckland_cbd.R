library(leaflet)

# Define the updated, more precise Christchurch CBD boundary including Hagley Park
auckland_cbd_coords <- list(
  c(174.7673, -36.8434),  # Point A: Quay Street (East)
  c(174.7568, -36.8450),  # Point B: Viaduct Harbour (West)
  c(174.7552, -36.8475),  # Point C: Victoria Park (Beaumont St)
  c(174.7574, -36.8583),  # Point D: Karangahape Road (Ponsonby Rd)
  c(174.7668, -36.8584),  # Point E: Karangahape Road (Symonds St)
  c(174.7703, -36.8538),  # Point F: Grafton Road (Symonds St)
  c(174.7713, -36.8506),  # Point G: Bottom of Symonds St
  c(174.7673, -36.8434)   # Closing Point A (Quay Street)
)


# Create a leaflet map and plot the Christchurch CBD boundary
leaflet() %>%
  addTiles() %>%
  addPolygons(
    lng = sapply(auckland_cbd_coords, function(x) x[1]),
    lat = sapply(auckland_cbd_coords, function(x) x[2]),
    color = "blue",  # Border color
    fillColor = "lightblue",  # Fill color
    fillOpacity = 0.5,  # Opacity of the polygon fill
    weight = 2,  # Thickness of the border line
    popup = "Auckland CBD"
  ) %>%
  setView(174.7645, lat = -36.8509, zoom = 13)


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
auckland_cbd_names <- c("Quay Street-Customs Street", "Wynyard-Viaduct","College Hill" ,"Victoria Park", 
                        "Anzac Avenue","Hobson Ridge North","Hobson Ridge South","Hobson Ridge Central","Shortland Street","The Strand", "Symonds Street", "Symonds Street West","Symonds Street North West", 
                        "Māngere Bridge","Auckland-University","Karangahape East" ,"Queen Street South West","Karangahape West","Queen Street"
                         )
#filtering to find chch cbd
auckland_data <- sa2_ta %>%
  filter(Area_Name %in% auckland_cbd_names)

#merging filtered data with shapefile with SA2 Code
merge_map_data <- right_join(shapefile_data, auckland_data, by = c("SA22023_V1" = "SA2_Code"))


# Plotting the christchurch region
auckland_region <- ggplot(data = merge_map_data) +
  geom_sf() +
  geom_sf_text(aes(label = SA22023_V1), size = 3, color = "black") +
  ggtitle("Map of Auckland CBD") +
  theme_void()

auckland_region
