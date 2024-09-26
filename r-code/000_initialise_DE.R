# conditionally install packages
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}
if (!requireNamespace("arrow", quietly = TRUE)) {
  install.packages("arrow")
}


# Load libraries
library(dplyr)
library(readr)
library(arrow)

# current date in YYYYMMDD format
current_date <- format(Sys.Date(), "%Y%m%d")

# existing filepaths (files were manually placed into this folder)
vf_file <- "./data/vf_data.parquet"
sp_file <- "./data/sp_data.csv.gz"

# output filepaths (files will be created from this R script)
vf_output_file <- paste0("./data/", current_date, ".clean-vf_data.csv")
sp_output_file <- paste0("./data/", current_date, ".clean-sp_data.csv")

# read vf_data.parquet file and save as a .csv
#
if (file.exists(vf_file)) {
  vf_data <- read_parquet(vf_file)
  write_csv(vf_data, vf_output_file)
} 
head(vf_data)
vf_exists = file.exists(vf_output_file)


# read sp_data.csv.gz file and save as a .csv
#
if (file.exists(sp_file)) {
  sp_data <- read_csv(sp_file, show_col_types = FALSE)
  write_csv(sp_data, sp_output_file)
} 
head(sp_data)
sp_exists = file.exists(sp_output_file)

# Print paths of the saved file
cat("Files saved successfully:\n",
  "New VF data csvfile: ", vf_output_file, "exists:", vf_exists, "\n",
  "New SP data csvfile: ", sp_output_file, "exists:", sp_exists, "\n")


