


read_VF_parquet <- function( folder = "./data/", filename = "vf_data.parquet", write_RDS = FALSE) {
  #browser()
  # current date in YYYYMMDD format
  current_date <- format(Sys.Date(), "%Y%m%d")
  
  # Input and output files
  file_rds <- file_path_sans_ext(filename)
  file_rds <- paste0(current_date,".", file_rds,".RDS")
  file_rds <- file.path(folder, file_rds)
  file_in  <- file.path(folder, filename) 
  
  
  if (!file.exists(file_in)) {
    cat("Error:", file_in, " does not exist.\n")
    return(NULL)  # Return NULL 
  }
  
  # Remove existing output file if it exists
  if (write_RDS && file.exists(file_rds) && !file.remove(file_rds)) {
    cat("Error deleting ", file_rds, "\n")
    return(NULL)
  }
  
  result   <- arrow::read_parquet(file_in)
  
  #struct_df(data,"vf_data")
  #browser()
  
  #write rds file
  if(write_RDS) write_rds(result,file_rds)
  #browser() 
  # Return the result
  return(result)
}

read_SP_gz <- function( folder = "./data/", filename = "sp_data.csv.gz", write_RDS = FALSE) {
  #browser()
  # current date in YYYYMMDD format
  current_date <- format(Sys.Date(), "%Y%m%d")
  
  # Input and output files
  file_rds <- file_path_sans_ext(filename)
  file_rds <- file_path_sans_ext(file_rds)
  file_rds <- paste0(current_date,".", file_rds,".RDS")
  file_rds <- file.path(folder, file_rds)
  file_in  <- file.path(folder, filename) 
  
  if (!file.exists(file_in)) {
    cat("Error:", file_in, " does not exist.\n")
    return(NULL)  # Return NULL 
  }
  
  # Remove existing output file if it exists
  if (write_RDS && file.exists(file_rds) && !file.remove(file_rds)) {
    cat("Error deleting ", file_rds, "\n")
    return(NULL)
  }
  
  result <- vroom(file_in,show_col_types = FALSE)
  
  #struct_df(data,"vf_data")
  #browser()
  
  #write rds file
  if(write_RDS) write_rds(result,file_rds)
  #browser() 
  # Return the result
  return(result)
}

vf_data = read_VF_parquet()
sp_data = read_SP_gz()
