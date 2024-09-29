# File: unittest-celldata.R
library(arrow)  
# Load the readVF.R file
source("./r-code/000_read_SP_DE.R")
source("./r-code/000_read_VF_DE.R")

# Call the read_VF_parquet function
result1 <- read_VF_parquet( write_RDS = TRUE)
# Print the output
if (!is.null(result1)) {
  print("result1")  # Print the tibble returned by the function
} else {
  cat("result1 is NULL.\n")
}



# Call the read_VF_parquet function
result2 <- read_SP_gz( write_RDS = TRUE)
# Print the output
if (!is.null(result2)) {
  print("result2")  # Print the tibble returned by the function
} else {
  cat("result2 is NULL.\n")
}

