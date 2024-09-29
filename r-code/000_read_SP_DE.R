# File: read_SP_DE.R


library(readr)
read_SP_gz <- function( folder = "./data/", filename = "sp_data.csv.gz", write_RDS = FALSE) {

  # current date in YYYYMMDD format
  current_date <- format(Sys.Date(), "%Y%m%d")
  
  # Input and output files
  sp_output_rds <- paste0(current_date,"_clean_sp_data.rds")
  sp_output_rds <- paste0(folder, sp_output_rds) 
  sp_input_file <- paste0(folder, filename) 

  if (!file.exists(sp_input_file)) {
    cat("Error:", sp_input_file, " does not exist.\n")
    return(NULL)  # Return NULL 
  }
  
  # Remove existing output file if it exists
  if (file.exists(sp_output_rds) && !file.remove(sp_output_rds)) {
    cat("Error deleting ", sp_output_rds, "\n")
  }
  
  result <- read_csv(sp_input_file, show_col_types = FALSE)
  column_spec <- spec(result)
  #write rds file
  if(write_RDS) write_rds(result,sp_output_rds)
  browser() 
  # Return the result
  return(result)
}