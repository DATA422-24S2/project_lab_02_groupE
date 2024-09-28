# conditionally install packages
if(!require(RPostgres)) {
  install.packages("RPostgres")}

#manually moved the files. getting the files from working directory 
sa2_ta_concord <- "./data/sa2_ta_concord_2023.csv"
urban_rr_i <- "./data/urban_rural_to_indicator_2023.csv"

#formatting 
current_date <- '20240929'
# output filepaths (files will be created from this R script)
sa2_t_c_output_file <- paste0("./data/", current_date, ".clean-sa2_ta_concord_data.csv")
urban_rr_i_output_file <- paste0("./data/", current_date, ".clean-urban_rr_indicator_data.csv")

sa2_t_c_data <- read.csv(sa2_ta_concord)
urban_rr_i_data <- read.csv(urban_rr_i)


#checking whether file exists or not
sa2_t_c_exists <- file.exists('sa2_t_c_output_file ')
urban_rr_i_exists <- file.exists('urban_rr_i_output_file')



# Print message to show paths of the saved file
cat("Files saved successfully:\n",
    "New sa2_ta_concord data csvfile: ", sa2_t_c_output_file, "exists:", sa2_t_c_exists, "\n",
    "New urban_rr_i data csvfile: ", urban_rr_i_output_file, "exists:", urban_rr_i_exists, "\n")