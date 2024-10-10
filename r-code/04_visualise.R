# 04_visualise.R
#
# Once you merge, run .test/INTEGRATION_TEST_celldata.R to ensure celldata 
# is still working
#
# Also, write your own Integration test and PUT ITS NAME HERE so we can 
# ensure we dont affect your work 
#
library(dplyr)
library("readr")
library(sf)



######################-akl map visualizations##########################################
source("./maps/000_auckland_cbd.R")
akl_leaflet_map
auckland_cbd



######################chc map visualizations##########################################

source("./maps/000_christchurch_cbd.R")




#####################wlg map visualizations##########################################
source("./maps/000_wellington_cbd.R")
wlg_leaflet_map
wellington_cbd




######################-celldata analysis code ##############################################
#
#  this write is done prior to the visualisation such that others can use the data
#  as a means of generating their visualisations (bar charts line graphs etc.)
#
# browse()
# source("./r-code/004_visualise_celldata.R")
# write_assignment_celldata(folder_data,file_celldata,cellphone_data)
#
#
#
######################-celldata export code ##############################################



