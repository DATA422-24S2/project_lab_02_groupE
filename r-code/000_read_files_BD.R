#file 1: sa2_2023
library(readr)
read_sa2_2023 <- function( folder = "./data/", filename = "sa2_2023.csv", write_RDS = FALSE) {
  #browser()
  # current date in YYYYMMDD format
  current_date <- format(Sys.Date(), "%Y%m%d")
  
  # Input and output files
  sa2_2023_output_rds <- paste0(current_date,"_sa2_2023.csv.rds")
  sa2_2023_output_rds <- file.path(folder, sa2_2023_output_rds) 
  sa2_2023_input_file <- file.path(folder, filename) 
  
  if (!file.exists(sa2_2023_input_file)) {
    cat("Error:", sa2_2023_input_file, " does not exist.\n")
    return(NULL)  # Return NULL 
  }
  
  # Remove existing output file if it exists
  if (file.exists(sa2_2023_output_rds) && !file.remove(sa2_2023_output_rds)) {
    cat("Error deleting ", sa2_2023_output_rds, "\n")
    return(NULL)
  }
  
  result <- read_csv(sa2_2023_input_file, skip = 6, show_col_types = FALSE)
  column_spec <- spec(result)
  #write rds file
  if(write_RDS) write_rds(result,sa2_2023_output_rds)
  #browser() 
  # Return the result
  return(result)
}

#file 2: subnational_pop_ests
read_subnational_pop <- function( folder = "./data/", filename = "subnational_pop_ests.csv", write_RDS = FALSE) {
  #browser()
  # current date in YYYYMMDD format
  current_date <- format(Sys.Date(), "%Y%m%d")
  
  # Input and output files
  subnational_pop_output_rds <- paste0(current_date,"_subnational_pop_ests.csv.rds")
  subnational_pop_output_rds <- file.path(folder, subnational_pop_output_rds) 
  subnational_pop_input_file <- file.path(folder, filename) 
  
  if (!file.exists(subnational_pop_input_file)) {
    cat("Error:", subnational_pop_input_file, " does not exist.\n")
    return(NULL)  # Return NULL 
  }
  
  # Remove existing output file if it exists
  if (file.exists(subnational_pop_output_rds) && !file.remove(subnational_pop_output_rds)) {
    cat("Error deleting ", subnational_pop_output_rds, "\n")
  }
  
  result <- read_csv(subnational_pop_input_file, show_col_types = FALSE)
  column_spec <- spec(result)
  #write rds file
  if(write_RDS) write_rds(result,subnational_pop_output_rds)
  #browser() 
  # Return the result
  return(result)
}

sa2_2023_data_2 = read_sa2_2023()
sub_pop_data_2 = read_subnational_pop()

#View(sa2_2023_data_2)
#View(sub_pop_data_2)