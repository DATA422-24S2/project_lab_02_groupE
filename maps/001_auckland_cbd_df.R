
# Load dplyr package if not already loaded
library(dplyr)
library("readr")
# Load the file
data <- read_csv("./data/clean_sa2_ta_concord_data.csv")

# Create a separate dataframe where TA_Name == "Auckland"
auckland_data <- subset(data, TA_Name == "Auckland")

# Filter the auckland_data dataframe for specific area names
auckland_cbd_areas <- c("Quay Street-Customs Street", "Wynyard-Viaduct", "Victoria Park", 
                        "Ponsonby East", "Symonds Street", "Grafton", "Quay Street-Customs Street")

# Use dplyr to filter for rows where Area_Name matches any of the CBD area names
auckland_cbd_sa2_data <- auckland_data %>%
  filter(Area_Name %in% auckland_cbd_areas)

# Extract the SA2_Code values for these areas
auckland_cbd_sa2_codes <- auckland_cbd_sa2_data$SA2_Code

# Print the SA2 codes
#print(auckland_cbd_sa2_codes)
