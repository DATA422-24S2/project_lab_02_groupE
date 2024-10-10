# Load required libraries

library(readr)

filter_wellington_cbd_data <- function(data = clean_sa2_ta_concord, output_file = "./data/assignment.WLG.RDS",
                                     save_rds = FALSE, wellington_cbd_areas = c("Wellington Central")) {


  #Filter for Wellington Central specifically (SA22023_V1 = 251400)
  wellington_cbd_sa2_data <- clean_sa2_ta_concord %>%
    filter(Area_Name == "Wellington Central")
  
  wellington_cbd_sa2_codes <- wellington_cbd_sa2_data$SA2_Code
  
  # optional: save files as RDS
  if (save_rds) {
    saveRDS(wellington_cbd_sa2_data, file = output_file)
  }
  # Return the filtered data and SA2 codes as a list 
  return(wellington_cbd_sa2_data)

  #saveRDS(wellington_cbd_sa2_data, file = "assignment.WLG.RDS")
}
