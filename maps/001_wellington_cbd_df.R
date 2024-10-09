# Load required libraries

library(readr)

#source("./test/002_clean_files_BD.R")
sa2_ta <- read_csv('./data/clean_sa2_ta_concord_data.csv')

#Import the shapefile
read_shapefile <- './data/statistical-area-2-2023-generalised.shp'
shapefile_data <- st_read(read_shapefile)


#Ensure shapefile columns have correct types
sa2_ta$SA2_Code <- as.integer(sa2_ta$SA2_Code)

#Filter for Wellington Central specifically (SA22023_V1 = 251400)
wellington_cbd_sa2_data <- sa2_ta %>%
  filter(Area_Name == "Wellington Central")

wellington_cbd_sa2_code <- wellington_cbd_sa2_data$SA2_Code


