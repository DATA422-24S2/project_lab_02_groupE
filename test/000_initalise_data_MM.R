library("sf")
library("readr")
#Reading CSV file and renaming dataframe columns

sa2_ta_concord <- "./data/sa2_ta_concord_2023.csv"
urban_rr_i <- "./data/urban_rural_to_indicator_2023.csv"


# output file paths
#sa2_t_c_output_file <- paste0("./data/", current_date, ".clean-sa2_ta_concord_data.csv")
#urban_rr_i_output_file <- paste0("./data/", current_date, ".clean-urban_rr_indicator_data.csv")

#col names for sa2_t_c_data
sa2_column_names <- c("SA2_Code", "Area_Name", "Relationship", "TA_Code", "TA_Name")
urb_column_names <- c("UR_Code", "Area_Name", "Relationship", "Indicator_Code", "Indicator_Description")

# reading CSV files, skip the correct number of rows (adjust skip value based on file structure)
sa2_t_c_data2 <- read_csv(sa2_ta_concord, skip=7, col_names = sa2_column_names, show_col_types = FALSE)
urban_rr_i_data2 <- read_csv(urban_rr_i, skip = 7, col_names = urb_column_names, show_col_types = FALSE)


#removing unnecessary column
sa2_t_c_data2 <- sa2_t_c_data[, !names(sa2_t_c_data) %in% c("X6")]
urban_rr_i_data2 <- urban_rr_i_data[, !names(urban_rr_i_data) %in% c("X6")]

#Cleaning data. Keeping only valid rows
sa2_t_c_data2 <- sa2_t_c_data2 %>%
  filter(!is.na(TA_Code) & TA_Code != "")

