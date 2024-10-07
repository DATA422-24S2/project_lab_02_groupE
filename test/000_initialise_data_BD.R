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

# file names import
sa2_2023 <- "./data/sa2_2023.csv"
subnational_pop <- "./data/subnational_pop_ests.csv"

sa2_2023_output_file <- paste0("./data/", ".clean-sa2_2023.csv")
subnational_pop_output_file <- paste0("./data/", ".clean-subnational_pop_ests.csv")

sa2_2023_col <- c("SA2_Code", "TA_Name")
sub_pop_col <- c("Structure", "Structure_ID", "Structure_Name", "Action", "Year_Popes_Sub_006",
                 "Year at 30 June", "Sex_Popes_Sub_006", "Sex", "Age_Popes_Sub_006", "Age", "SA2_Code", 
                 "Area", "Observation_Value", "Observation Value")

# Read the CSV files
sa2_2023_data <- read_csv(sa2_2023, skip = 7, col_names = sa2_2023_col, show_col_types = FALSE)
subnational_pop_data <- read_csv(subnational_pop, skip = 1, col_names = sub_pop_col, show_col_types = FALSE)

sa2_2023_data_2 <- sa2_2023_data[, !names(sa2_2023_data) %in% c("X3")]
subnational_pop_data_2 <- subnational_pop_data[, !names(subnational_pop_data) %in% c("Area", "Observation Value")]

write_csv(sa2_2023_data_2, sa2_2023_output_file)
write_csv(subnational_pop_data_2, subnational_pop_output_file)

View(sa2_2023_data_2)
View(subnational_pop_data_2)