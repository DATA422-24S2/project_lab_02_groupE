read_christchurch_cbd_df <- function(folder = "./maps/", filename = "001_christchurch_cbd_df.R") {
  
  # Input and output file paths
  rds_output_file <- paste0(folder, "assignment.CHC.RDS")
  input_file <- paste0(folder, filename)
  
  # Check if the input file exists
  if (!file.exists(input_file)) {
    cat("Error:", input_file, "does not exist.\n")
    return(NULL)  # Return NULL if the file doesn't exist
  }
  
  # Remove the existing RDS output file if it exists
  if (file.exists(rds_output_file) && !file.remove(rds_output_file)) {
    cat("Error deleting", rds_output_file, "\n")
  }
  
  # Source the R script (this will run the script and load its contents)
  source(input_file)
  
  # Assuming that the sourced script creates a data frame called 'result'
  if (!exists("result")) {
    cat("Error: The sourced script did not create an object named 'result'.\n")
    return(NULL)  # Return NULL if 'result' is not created
  }
  
  # Write the 'result' object to an RDS file
  write_rds(result, rds_output_file)
  cat("RDS file created:", rds_output_file, "\n")
  
  # Optionally, inspect the result using browser for debugging purposes
  browser()
  
  # Return the result
  return(result)
}
