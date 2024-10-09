# Load required libraries

library(readr)

#source("./test/002_clean_files_BD.R")
sa2_ta <- read_csv('./data/clean_sa2_ta_concord_data.csv')


#Ensure shapefile columns have correct types
sa2_ta$SA2_Code <- as.integer(sa2_ta$SA2_Code)

#Filter for Wellington Central specifically (SA22023_V1 = 251400)
wellington_cbd_sa2_data <- sa2_ta %>%
  filter(Area_Name == "Wellington Central")

wellington_cbd_sa2_code <- wellington_cbd_sa2_data$SA2_Code


saveRDS(wellington_cbd_sa2_data, file = "assignment.WLG.RDS")

