#test-celldata-functions.R
#library(rstudioapi)
#print(rstudioapi::getSourceEditorContext()$path)
#
#
# This file is exclusively for detailed analysis of the celldata functions
#
#

#browser()
source("./r-code/00_initialise.R")
source("./r-code/001_import_celldata.R")
source("./r-code/002_clean_celldata.R")
source("./r-code/003_analyse_celldata.R")
source("./r-code/004_visualise_celldata.R")
source("./r-code/005_export_celldata.R")
source("./test/analyse-celldata-structure.R")

DEEBUG_CELLDATA = TRUE

# time bound one of the preprocessed tibbles 
#

# REQUIRED TIME VALUES
# REQUIRED TIME VALUES
#
# Assume the first week in the data is a regular working week and the following week is a week of school holidays.
#
#
# Normal week:
#  
#  Start: "2024-06-03 00:00:00"
#
# End: "2024-06-09 23:59:00"
#
# Holiday week:
#  
#  Start: "2024-06-10 00:00:00"
#
# End: "2024-06-16 23:59:00"
#
# REQUIRED TIME VALUES
# REQUIRED TIME VALUES
#
normal_week_start  <- as.POSIXct("2024-06-03 00:00:00", tz = "Pacific/Auckland")
normal_week_stop   <- as.POSIXct("2024-06-09 23:59:59", tz = "Pacific/Auckland")
holiday_week_start <- as.POSIXct("2024-06-10 00:00:00", tz = "Pacific/Auckland")
holiday_week_stop  <- as.POSIXct("2024-06-16 23:59:00", tz = "Pacific/Auckland")

#browser()
vf_data = read_VF_parquet()              ## also performed in  ./r-code/01_import.R
struct_df(vf_data,"vf_data",print_tail = TRUE)
vf_prep = preprocess_vf_data(vf_data)
struct_df(vf_prep,"vf_prep") 

sp_data = read_SP_gz()                   ## also performed in  ./r-code/01_import.R
struct_df(sp_data,"sp_data",print_tail = TRUE)
sp_prep = preprocess_sp_data(sp_data)
struct_df(sp_prep,"sp_prep")



#browser()

vf_timed = time_bound(vf_prep, tb_name = "vf_timed",normal_week_start,holiday_week_stop)
sp_timed = time_bound(sp_prep, tb_name = "sp_timed",normal_week_start,holiday_week_stop)
struct_df(vf_timed,"vf_timed",print_tail = TRUE)
struct_df(sp_timed,"sp_timed",print_tail = TRUE)
#browser()
vf_timed <- remove_NA0(vf_timed)
sp_timed <- remove_NA0(sp_timed)
vf_timed <- remove_istimed(vf_timed)
sp_timed <- remove_istimed(sp_timed)

struct_df(vf_timed,"vf_timed",print_tail = TRUE)
struct_df(sp_timed,"sp_timed",print_tail = TRUE)

# Check for duplicates 
#browser()
vf_processed <- process_duplicates(vf_timed,"vf_timed")
sp_processed <- process_duplicates(sp_timed,"sp_timed")
#browser()
vf_test_duplicates = has_duplicates(vf_processed,"vf_processed")
sp_test_duplicates = has_duplicates(sp_processed,"sp_processed")
#cellphone_data <- merge_processed_celldata(vf_processed,sp_processed,saveas_RDS = TRUE) #geneate a cellphone_data.RDS file
 cellphone_data <- merge_processed_celldata(vf_processed,sp_processed)
#browser()
#struct_df(cellphone_data,"cellphone_data",TRUE)

test_sa_file  =  "./data/urban_rural_to_indicator_2023.csv"
test_sa_file  =  "./data/urban_rural_to_sa2_concord_2023.csv"
test_sa_file  =  "./data/sa2_2023.csv"
test_cellfile =  "./data/assignment.celldata.RDS"  
#browser()

test_sa_data   <- suppressWarnings(read_csv(test_sa_file,  show_col_types = FALSE))
test_celldata  <- read_rds(test_cellfile)
#parsing_issues <- problems(df)
#cat("parsing issues start")
#print(parsing_issues)  #  parsing problems
#cat("parsing issues end")


test_sa <- test_sa_data %>%
  slice(-1:-10) %>%
  rename(SA2 = `Classification report`, location = `...2`) %>%
  mutate(SA2 = as.numeric(SA2)) %>%
  slice(1:10)


print("test_celldata:")
print(head(test_celldata))
print("test_sa:")
print(head(test_sa))

# Check if SA2 columns match in both datasets before join
common_SA2 <- intersect(test_celldata$sa2, test_sa$SA2)
print("Common SA2 values:")
print(common_SA2)

# Proceed with join if there are common SA2 values
#if(length(common_SA2) > 0) {
#  browser()
#  tb         = test_celldata
#  sa         = test_sa  
#  time_start = normal_week_start
#  time_stop  = holiday_week_stop
#  
#
#    
#    # tb rows within the time range (inclusive)
#  filtered_tb <- tb %>%
#      filter(NZST >= time_start & NZST <= time_stop)
#    
#    #  join between the filtered tb and sa based on the  SA and SA2 columns match
#    #  group by NZST and calculate the sum of the 'sum' column from tb
#    result <- filtered_tb %>%
#      inner_join(sa, by = c("SA2" = "sa2")) %>%    # Join on matching SA and SA2 columns
#      group_by(NZST) %>%                         # Group by NZST (time)
#      summarise(SA2 = min(SA2),                     # Keep the minimum SA value for each group
#         total_sum = sum(sum))             # Sum the 'sum' column for each time entry
#    
#    
#  }
#  print("Result:")
#  print(head(result))
#
# browser()
