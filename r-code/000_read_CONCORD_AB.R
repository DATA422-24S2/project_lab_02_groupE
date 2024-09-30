library(readr)
read_concod_csv <- function( folder = "./data/", filename = "urban_rural_to_sa2_concord_2023.csv", write_RDS = FALSE) {
  
  #current date
  current_date = format(Sys.Date(), "%Y%m%d")
  
  #input and output files
  concord_output_rds <- paste0(current_date,  "_urban_rural_to_sa2_concord_2023.rds")
  concord_output_rds <- paste0(folder, concord_output_rds)
  concord_input_file <- paste0(folder, filename)
  
  if (!file.exists(concord_input_file)) {
    cat("Error:", concord_input_file, " does not exist.\n")
    return(NULL)  # Return NULL 
  }
  
  # Remove existing output file if it exists
  if (file.exists(concord_output_rds) && !file.remove(concord_output_rds)) {
    cat("Error deleting ", concord_output_rds, "\n")
  }
  
  result <- read_csv(concord_input_file, show_col_types = FALSE)
  column_spec <- spec(result)
  #write rds file
  if(write_RDS) write_rds(result,concord_output_rds)
  browser() 
  # Return the result
  return(result)
}