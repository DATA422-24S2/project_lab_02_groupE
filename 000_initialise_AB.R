# Conditionally install packages
if(!require(RPostgres)) {
  install.packages("RPostgres")
}

# Manually moved the files. Getting the files from the working directory 
concord <- "./data/urban_rural_to_sa2_concord_2023.csv"

# Formatting 
current_date <- '20240929'

# Output filepaths (files will be created from this R script)
concord_output_file <- paste0("./data/", current_date, ".urban_rural_to_sa2_concord_2023.csv")

# Read the CSV file without setting row names
concord_data <- read.csv(concord, row.names = NULL, stringsAsFactors = FALSE)

# Save the file after reading
write.csv(concord_data, concord_output_file, row.names = FALSE)

# Check whether the output file exists or not
concord_exists <- file.exists(concord_output_file)

# Print message to show paths of the saved file
cat("Files saved successfully:\n",
    "New urban_rural_to_sa2_concord data csvfile: ", concord_output_file, "exists:", concord_exists, "\n")
