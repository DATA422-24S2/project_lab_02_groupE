# Load necessary libraries
library(dplyr)

# Load the dataset
subnational_pop <- read.csv("./data/subnational_pop_ests.csv")

# Inspect unique values in the Area_Code column to identify issues
unique_area_codes <- unique(subnational_pop$AREA_POPES_SUB_006)
print(unique_area_codes)

# Clean the dataset and convert Area_Code to integer
subnational_pop_cleaned <- subnational_pop %>%
  rename(
    Structure = STRUCTURE,
    Structure_ID = STRUCTURE_ID,
    Structure_Name = STRUCTURE_NAME,
    Action = ACTION,
    Year = YEAR_POPES_SUB_006,
    Year_at_30_June = Year.at.30.June,
    Sex_Code = SEX_POPES_SUB_006,
    Sex = Sex,
    Age_Group_Code = AGE_POPES_SUB_006,
    Age_Group = Age,
    Area_Code = AREA_POPES_SUB_006,
    Observation_Value = OBS_VALUE
  ) %>%
  # Convert Area_Code to character first, then to integer
  mutate(
    Area_Code = as.integer(as.character(Area_Code)),  # Convert to character to avoid factor issues
    Observation_Value = as.numeric(Observation_Value)  # Ensure Observation_Value is numeric
  ) %>%
  # Remove rows with NA in critical columns
  filter(!is.na(Area_Code), !is.na(Observation_Value))  # This line ensures we filter out NAs

# Check the structure of the cleaned dataset
str(subnational_pop_cleaned)

# Preview the first few rows of the cleaned data
View(subnational_pop_cleaned)

#---------------------------
#clean the sa2_2023 
# Load the dataset
sa2_2023 <- read.csv("./data/sa2_2023.csv", stringsAsFactors = FALSE)
View(sa2_2023)

# Step 1: Remove the first 6 rows
sa2_2023_clean <- sa2_2023[-c(1:6), ]

# Step 2: Rename columns to 'SA2_Code' and 'Area_Name'
colnames(sa2_2023_clean) <- c("SA2_Code", "Area_Name")

# Step 3: Convert SA2_Code to numeric and remove non-numeric entries
sa2_2023_clean <- sa2_2023_clean %>%
  mutate(SA2_Code = as.numeric(SA2_Code)) %>%
  filter(!is.na(SA2_Code))                      

View(sa2_2023_clean)
str(sa2_2023_clean)