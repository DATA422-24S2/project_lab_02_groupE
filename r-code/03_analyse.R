# 03_analyse.R
#
# Once you merge, run .test/INTEGRATION_TEST_celldata.R to ensure celldata 
# is still working
#
# Also, write your own Integration test and PUT ITS NAME HERE so we can 
# ensure we dont affect your work 
#
#


######################-Importing the shapefile data-###############################

#reading the csv file containing necessary data
sa2_ta <- clean_sa2_ta_concord

#Import the shapefile
read_shapefile <- './data/statistical-area-2-2023-generalised.shp'
shapefile_data <- st_read(read_shapefile, quiet = TRUE)


# Ensure consistent data types for the SA2 columns. Will be used later to create ggplot map
sa2_ta$SA2_Code <- as.integer(sa2_ta$SA2_Code)
shapefile_data$SA22023_V1 <- as.integer(shapefile_data$SA22023_V1)

######################-Importing necessary files to generate maps later-###############################

source("./maps/001_wellington_cbd_df.R")
source("./maps/001_auckland_cbd_df.R")
source("./maps/001_christchurch_cbd_df.R")

auckland_data <- filter_auckland_sa2_data()
wellington_data <- filter_wellington_cbd_data()
christchurch_data <- filter_christchurch_cbd_data()


######################-celldata analysis code ##############################################
#
#  this write is done prior to the visualisation such that others can use the data
#  as a means of generating their visualisations (bar charts line graphs etc.)
#
#browser()

source("./r-code/003_analyse_celldata.R")

write_assignment_celldata(folder_data,file_celldata,cellphone_data)
#
#
#
######################-celldata export code ##############################################



