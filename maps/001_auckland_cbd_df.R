
# Load dplyr package if not already loaded
library(dplyr)
library("readr")
# Load the file
data <- read_csv("./data/clean_sa2_ta_concord_data.csv")

# Create a separate dataframe where TA_Name == "Auckland"
auckland_data <- subset(data, TA_Name == "Auckland")

# Filter the auckland_data dataframe for specific area names
auckland_cbd_areas <-c("Quay Street-Customs Street", "Wynyard-Viaduct","College Hill" ,"Victoria Park", 
                       "Anzac Avenue","Hobson Ridge North","Hobson Ridge South","Hobson Ridge Central","Shortland Street","The Strand", "Symonds Street", "Symonds Street West","Symonds Street North West", 
                       "Māngere Bridge","Auckland-University","Karangahape East" ,"Queen Street South West","Karangahape West","Queen Street"
)

# Use dplyr to filter for rows where Area_Name matches any of the CBD area names
auckland_cbd_sa2_data <- auckland_data %>%
  filter(Area_Name %in% auckland_cbd_areas)

# Extract the SA2_Code values for these areas
auckland_cbd_sa2_codes <- auckland_cbd_sa2_data$SA2_Code


saveRDS(auckland_cbd_sa2_data, file = "./data/assignment.AKL.RDS")
