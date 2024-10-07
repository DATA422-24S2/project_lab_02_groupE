library("sf")
library("ggplot2")
library("dplyr")

#importing datafile
read_shapefile <- './data/statistical-area-2-2023-generalised.shp'
shapefile_data <- st_read(read_shapefile)

# View the structure of the shapefile data
str(shapefile_data)
# View a summary of the shapefile data
summary(shapefile_data)

# Ensure consistent data types for the SA2 columns
sa2_t_c_data2$SA2_Code <- as.character(sa2_t_c_data2$SA2_Code)
shapefile_data$SA22023_V1 <- as.character(shapefile_data$SA22023_V1)

#reading concord data
merge_map_data <- left_join(shapefile_data, sa2_t_c_data2, by = c("SA22023_V1" = "SA2_Code"))

## Create a new column to indicate polygons to highlight
#highlight_data <- merge_map_data %>%
  #mutate(highlight = ifelse(Area_Name %in% c("Wellington Central", "Thorndon", "Mount Victoria"), "highlight", "no_highlight"))

# Filter to only include Wellington
wellington_data <- merge_map_data %>%
  filter(Area_Name == "Wellington Central")

# Plot the Wellington region
ggplot(data = wellington_data) +
  geom_sf() +
  geom_sf_text(aes(label = SA22023_V1), size = 3, color = "black") +
  ggtitle("Map of Wellington CBD") +
  theme_void()


