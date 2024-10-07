# clean_data.R

# Source the import functions from the import_data.R script
source("./test/000_read_files_BD.R")

# Load necessary libraries
library(dplyr)
library(tibble)

# Check if the data was loaded
if (!is.null(sa2_2023_data)) {
  # Print column names for debugging
  print(colnames(sa2_2023_data))
  
  # Clean SA2 2023 data
  sa2_2023_clean <- sa2_2023_data[-c(1:6), ] %>%
    rename(Code = "Classification report",
           Names = "...2")
  
  # View the cleaned data
  View(sa2_2023_clean)
}

# Check if the data was loaded
if (!is.null(sub_pop_data)) {
  # Clean the subnational population data
  sub_pop_clean <- sub_pop_data %>%
#    rename(
#      Structure = STRUCTURE,
#      Structure_ID = STRUCTURE_ID,
#      Structure_Name = STRUCTURE_NAME,
#      Action = ACTION,
 #     Year = YEAR_POPES_SUB_006,
#      Sex_Code = SEX_POPES_SUB_006,
 #     Sex = Sex,
  #    Age_Group_Code = AGE_POPES_SUB_006,
  #    Age_Group = Age,
  #    Area_Code = AREA_POPES_SUB_006,
  #    Observation_Value = OBS_VALUE
   # ) %>%
    mutate(
      AREA_POPES_SUB_006 = as.character(AREA_POPES_SUB_006),
      Observation_Value = as.numeric(OBS_VALUE)
    ) %>%
    filter(!is.na(AREA_POPES_SUB_006), !is.na(Observation_Value)) %>%
    filter(grepl("^\\d+$", AREA_POPES_SUB_006))  # Keep numeric Area_Code
  
  # Print the structure of the cleaned data
  print(str(sub_pop_clean))
  
  # View the cleaned data
  View(sub_pop_clean)
}