# clean_data.R

# Source the import functions from the import_data.R script
source("./r-code/000_read_files_BD.R")

# Load necessary libraries
library(dplyr)
library(tibble)

# Check if the data was loaded
if (!is.null(sa2_2023_data_2)) {
  # Print column names for debugging
  print(colnames(sa2_2023_data_2))
  
  # Clean SA2 2023 data
  sa2_2023_clean <- sa2_2023_data_2[-c(1:6), ] %>%
    rename(Code = "Classification report",
           Names = "...2")
  
  # View the cleaned data
  View(sa2_2023_clean)
}

if (!is.null(sub_pop_data_2)) {
  # Clean the subnational population data
  sub_pop_clean <- sub_pop_data_2 %>%
    rename(
      SA2_Code = AREA_POPES_SUB_006
    ) %>%
    mutate(
      SA2_Code = as.integer(SA2_Code)
    ) %>%
    filter(!is.na(SA2_Code), !is.na("Observation Value")) %>%
    filter(grepl("^\\d+$", SA2_Code))  # Keep numeric Area_Code
  
  # Remove the two columns by specifying their names
  sub_pop_clean <- sub_pop_clean %>%
    select(-Area, -"Observation value")  # Replace 'column1' and 'column2' with actual column names
  
  # Print the structure of the cleaned data
  print(str(sub_pop_clean))
  
  # View the cleaned data
  View(sub_pop_clean)
}