library(readr)
library(dplyr)

# Define a function to filter Christchurch CBD data
filter_christchurch_cbd_data <- function( 
                               output_file = "assignment.CHC.RDS", 
                               save_rds = FALSE, 
                               chch_cbd_names = c("Christchurch Central", "Christchurch Central-West", 
                                                  "Christchurch Central-East", "Christchurch Central-North", 
                                                  "Christchurch Central-South", "Hagley Park")) {
  
  
  # Filter for Christchurch CBD areas using dplyr
  christchurch_cbd_sa2_data <- clean_sa2_ta_concord %>%
    filter(Area_Name %in% chch_cbd_names)
  
  # Extract the SA2_Code values for these areas (Optional, if you need the codes)
  christchurch_cbd_sa2_codes <- christchurch_cbd_sa2_data$SA2_Code
  
  # Optional: Save the filtered Christchurch CBD data as an RDS file if save_rds is TRUE
  if (save_rds) {
    saveRDS(christchurch_cbd_sa2_data, file = output_file)
  }
  
  # Return the filtered data frame directly
  return(christchurch_cbd_sa2_data)
}


