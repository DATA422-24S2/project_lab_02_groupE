library(leaflet)
library("sf")
library("ggplot2")
library("dplyr")

# Define the updated, more precise Wellington CBD boundary coordinates
wellington_bounds <- list(
  c(174.773209, -41.277922),  # Point 1
  c(174.776879, -41.278960),  # Point 2
  c(174.779354, -41.282097),  # Point 3
  c(174.779655, -41.291195),  # Point 4
  c(174.776231, -41.288885),  # Point 5
  c(174.775981, -41.289430),  # Point 6
  c(174.775031, -41.288622),  # Point 7
  c(174.774706, -41.289223),  # Point 8
  c(174.770682, -41.288735),  # Point 9
  c(174.773657, -41.282592)   # Closing point back to Point 1
)

# Create a leaflet map and plot the Wellington CBD boundary
leaflet() %>%
  addTiles() %>%
  addPolygons(
    lng = sapply(wellington_bounds, function(x) x[1]),
    lat = sapply(wellington_bounds, function(x) x[2]),
    color = "blue",  # Border color
    fillColor = "lightblue",  # Fill color
    fillOpacity = 0.5,  # Opacity of the polygon fill 
    weight = 2,  # Thickness of the border line
    popup = "Wellington CBD (251400)"
  ) %>%
  setView(lng = 174.7762, lat = -41.2865, zoom = 14)  # Centered in the Wellington CBD

#Wellington Central(251400)
# Define the Wellington Central boundary coordinates as a data frame
wellington_central_df <- data.frame(
  lng = sapply(wellington_bounds, function(x) x[1]),
  lat = sapply(wellington_bounds, function(x) x[2])
)

# Display the data frame
#print(wellington_central_df)

####The purpose of this code is to display the Wellington CBD SA2 Codes

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
wellington_cbd <- ggplot(data = wellington_map_data) +
  geom_sf() +
  geom_sf_text(aes(label = SA22023_V1), size = 3, color = "black") +
  ggtitle("Map of Wellington Central (251400)") +
  theme_void()
