#require libraries
library("tidyverse")
library("dplyr")
library("readr")
library("arrow")
library("tibble") 

# conditionally install packages
if(!require(RPostgres)) {
  install.packages("RPostgres")
}

#file names import
sa2_2023 <- "./data/sa2_2023.csv"
subnational_pop <- "./data/subnational_pop_ests.csv"

# current date in YYYYMMDD format
current_date <- format(Sys.Date(), "%Y%m%d")
sa2_2023_output_file <- paste0("./data/", current_date, ".clean-sa2_2023.csv")
subnational_pop_output_file <- paste0("./data/", current_date, ".clean-subnational_pop_ests.csv")

# Read the data
sa2_2023_data <- read.csv(sa2_2023, row.names = 1)
subnational_pop_data <- read.csv(subnational_pop)

#removing some variables as they are duplicates
#also renaming them
subnational_pop_clean <- subnational_pop_data %>%
  select(-Year.at.30.June, -Area, -Observation.value) %>%
  rename(
    "Year at June 2023" = "YEAR_POPES_SUB_006",  # Replace with your desired new names
    "Area" = "AREA_POPES_SUB_006",
    "Obervation value" = "OBS_VALUE"
  )

# Remove the second column from sa2_2023_data since it's nothing
# Move row names into a new column called "Code" (you can rename as necessary)
sa2_2023_clean <- sa2_2023_data %>%
  rownames_to_column(var = "Code") %>%
  select(-3)

# Write the cleaned data to the output files
write.csv(sa2_2023_clean, sa2_2023_output_file, row.names = FALSE)
write.csv(subnational_pop_clean, subnational_pop_output_file, row.names = FALSE)

# Check files exist
sa2_2023_exists <- file.exists(sa2_2023_output_file)
subnational_pop_exists <- file.exists(subnational_pop_output_file)

# Print message to show paths of the saved file
cat("Files saved successfully:\n",
    "New sa2_2023 data csvfile: ", sa2_2023_output_file, "exists:", sa2_2023_exists, "\n",
    "New subnational_pop data csvfile: ", subnational_pop_output_file, "exists:", subnational_pop_exists, "\n")

view(sa2_2023_clean)
view(subnational_pop_clean)