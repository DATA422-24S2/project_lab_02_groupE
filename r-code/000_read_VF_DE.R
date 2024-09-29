# File: read_VF_DE.R

library(arrow)  
library(readr)
read_VF_parquet <- function( folder = "./data/", filename = "vf_data.parquet", write_RDS = FALSE) {
  
  # current date in YYYYMMDD format
  current_date <- format(Sys.Date(), "%Y%m%d")
  
  # Input and output files
  vf_output_rds <- paste0(current_date,"_clean_vp_data.rds")
  vf_output_rds <- paste0(folder, vf_output_rds) 
  vf_input_file <- paste0(folder, filename)
  
  if (!file.exists(vf_input_file)) {
    cat("Error:", vf_input_file, " does not exist.\n")
    return(NULL)  # Return NULL 
  }
  
  # Remove existing output file if it exists
  if (file.exists(vf_output_rds) && !file.remove(vf_output_rds)) {
    cat("Error deleting ", vf_output_rds, "\n")
  }
  
  result <- arrow::read_parquet(vf_input_file)
  
  #write rds file
  if(write_RDS) write_rds(result,vf_output_rds)
  browser() 
  # Return the result
  return(result)
}
