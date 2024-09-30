library(readr)
library(tidyverse)

#set date
current_date <- format(Sys.Date(), "%Y%m%d")
raw_output_file <- paste0("./data/", current_date, ".urban_rural_to_sa2_concord_2023.csv")
# Read the CSV without treating any column as row names
raw_data <- read.csv("./data/urban_rural_to_sa2_concord_2023.csv", header = TRUE, row.names = NULL)


write.csv(raw_data, raw_output_file, row.names = FALSE)
