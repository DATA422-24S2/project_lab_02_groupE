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

# current date in YYYYMMDD format
current_date <- format(Sys.Date(), "%Y%m%d")
sa2_2023_output_file <- paste0("./data/", current_date, ".clean-sa2_2023.csv")
subnational_pop_output_file <- paste0("./data/", current_date, ".clean-subnational_pop_ests.csv")

# Read the CSV files
sa2_2023_data <- read.csv(sa2_2023)
subnational_pop_data <- read.csv(subnational_pop)

# Write the cleaned data to the output files
write.csv(sa2_2023_data, sa2_2023_output_file, row.names = FALSE)
write.csv(subnational_pop_data, subnational_pop_output_file, row.names = FALSE)