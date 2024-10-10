
# Load dplyr package if not already loaded
library(dplyr)
library("readr")

# function to load and filter auckland data
filter_auckland_sa2_data <- function(input_file = "./data/clean_sa2_ta_concord_data.csv", 
                                     output_file = "./data/assignment.AKL.RDS", 
                                     save_rds = FALSE,  # Optional RDS saving
                                     auckland_cbd_areas = c("Quay Street-Customs Street", "Wynyard-Viaduct", "College Hill", "Victoria Park", 
                                                            "Anzac Avenue", "Hobson Ridge North", "Hobson Ridge South", "Hobson Ridge Central", 
                                                            "Shortland Street", "The Strand", "Symonds Street", "Symonds Street West", 
                                                            "Symonds Street North West", "Māngere Bridge", "Auckland-University", 
                                                            "Karangahape East", "Queen Street South West", "Karangahape West", "Queen Street")) {
  
  # loads the required data file
  data <- read_csv(input_file)
  
  # Gets data from auckland
  auckland_data <- subset(data, TA_Name == "Auckland")
  
  # Use dplyr to filter for rows where Area_Name matches any of the CBD area names
  auckland_cbd_sa2_data <- auckland_data %>%
    filter(Area_Name %in% auckland_cbd_areas)
  
  # Extract the SA2_Code values for these areas (Optional: if you need the codes)
  auckland_cbd_sa2_codes <- auckland_cbd_sa2_data$SA2_Code
  
  # Optional: Save the filtered Auckland CBD data as an RDS file if save_rds is TRUE
  if (save_rds) {
    saveRDS(auckland_cbd_sa2_data, file = output_file)
  }
  
  # Return the filtered data and SA2 codes as a list (Optional, for further use)
  return(auckland_cbd_sa2_data)
  
}

