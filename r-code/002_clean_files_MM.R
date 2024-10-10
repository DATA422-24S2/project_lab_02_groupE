

#removing unnecessary column
sa2_ta_concord <- sa2_ta_concord[, !names(sa2_ta_concord) %in% c("X6")]
urban_rr_indicator <- urban_rr_indicator[, !names(urban_rr_indicator) %in% c("X6")]


# Count total NA values in the entire data frame
total_na_sa2 <- sum(is.na(sa2_ta_concord))
total_na_urban_rr <- sum(is.na(urban_rr_indicator))

# Print strings to show total NA values 
#cat("Total NA values in sa2_ta_concord:", total_na_sa2, "\n")
#cat("Total NA values in urban_rr_indicator:", total_na_urban_rr, "\n")

# Remove NA
clean_sa2_ta_concord <- na.omit(sa2_ta_concord)
clean_urban_rr_indicator <- na.omit(urban_rr_indicator)


