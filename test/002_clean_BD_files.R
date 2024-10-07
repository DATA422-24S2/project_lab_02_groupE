# Load the necessary libraries
library(dplyr)
library(tibble)

# Load the dataset
source("./test/000_initialise_data_BD.R")

# Clean the dataset and convert Area_Code to integer
subnational_pop_cleaned <- subnational_pop_data_2 %>%
  # Convert Area_Code to character first, then to integer
  mutate(
    SA2_Code = as.character(SA2_Code),  # Convert to character to avoid factor issues
    Observation_Value = as.numeric(Observation_Value)  # Ensure Observation_Value is numeric
  ) %>%
  # Remove rows with NA in critical columns
  filter(!is.na(SA2_Code), !is.na(Observation_Value)) %>%
  filter(grepl("^\\d+$", SA2_Code)) 

View(subnational_pop_cleaned)

#no clean for sa2_2023
