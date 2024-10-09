# Format the date to match the filename format



# Construct the filename
filename <- "./data/clean_sa2_ta_concord_data.csv"

# Load the file
data <- read.csv(filename, header = TRUE, sep = ",", row.names = NULL)
View(data)

# Create a separate dataframe where TA_Name == "Auckland"
auckland_data <- subset(data, TA_Name == "Auckland")

# View the new dataframe
View(auckland_data)

# Load dplyr package if not already loaded
library(dplyr)

# Filter the auckland_data dataframe for specific area names
auckland_cbd_areas <- c("Quay Street-Customs Street", "Wynyard-Viaduct", "Victoria Park", 
                        "Ponsonby East", "Symonds Street", "Grafton", "Quay Street-Customs Street")

# Use dplyr to filter for rows where Area_Name matches any of the CBD area names
auckland_cbd_sa2_data <- auckland_data %>%
  filter(Area_Name %in% auckland_cbd_areas)

# Extract the SA2_Code values for these areas
auckland_cbd_sa2_codes <- auckland_cbd_sa2_data$SA2_Code

# Print the SA2 codes
print(auckland_cbd_sa2_codes)