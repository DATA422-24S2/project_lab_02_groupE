# conditionally install packages
if(!require(RPostgres)) {
  install.packages("RPostgres")}

read_sa2_ta_concord <- function(folder = "./data/", filename = "sa2_ta_concord_2023.csv", write_RDS = FALSE) {
  # current date in YYYYMMDD format
  current_date <- format(Sys.Date(), "%Y%m%d")
  
  # Input and output files
  sa2_ta_concord_rds <- paste0(current_date, "_sa2_ta_concord.rds")
  sa2_ta_concord_rds <- file.path(folder, sa2_ta_concord_rds) 
  sa2_ta_concord_input_file <- file.path(folder, filename) 
  
  if (!file.exists(sa2_ta_concord_input_file)) {
    cat("Error:", sa2_ta_concord_input_file, " does not exist.\n")
    return(NULL)  # Return NULL 
  }
  
  # Remove existing output file if it exists
  if (file.exists(sa2_ta_concord_rds) && !file.remove(sa2_ta_concord_rds)) {
    cat("Error deleting ", sa2_ta_concord_rds, "\n")
    return(NULL)
  }
  
  # Read the CSV file
  result <- read_csv(sa2_ta_concord_input_file, show_col_types = FALSE)
  
  # Save the result as an RDS file if needed
  if (write_RDS) {
    write_rds(result, sa2_ta_concord_rds)
  }
  
  # Return the result (the read data)
  return(result)
}

read_urban_rural_indicator <- function(folder = "./data/", filename = "urban_rural_to_indicator_2023.csv", write_RDS = FALSE) {
  # current date in YYYYMMDD format
  current_date <- format(Sys.Date(), "%Y%m%d")
  
  # Input and output files
  urban_rural_rds <- paste0(current_date, "_urban_rural_indicator.rds")
  urban_rural_rds <- file.path(folder, urban_rural_rds) 
  urban_rural_input_file <- file.path(folder, filename) 
  
  if (!file.exists(urban_rural_input_file)) {
    cat("Error:", urban_rural_input_file, " does not exist.\n")
    return(NULL)  # Return NULL 
  }
  
  # Remove existing output file if it exists
  if (file.exists(urban_rural_rds) && !file.remove(urban_rural_rds)) {
    cat("Error deleting ", urban_rural_rds, "\n")
    return(NULL)
  }
  
  # Read the CSV file
  result <- read_csv(urban_rural_input_file, show_col_types = FALSE)
  
  # Save the result as an RDS file if needed
  if (write_RDS) {
    write_rds(result, urban_rural_rds)
  }
  
  # Return the result (the read data)
  return(result)
}
