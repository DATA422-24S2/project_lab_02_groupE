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
source("./r-code/01_import.R")
source("./test/002_clean_celldata.R")
source("./r-code/003_analyse_celldata.R")
source("./r-code/004_visualise_celldata.R")
source("./test/analyse-celldata-structure.R")
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


normal_week_start  <- as.POSIXct("2024-06-03 00:00:00")
normal_week_stop   <- as.POSIXct("2024-06-09 23:59:59")
holiday_week_start <- as.POSIXct("2024-06-10 00:00:00")
holiday_week_stop  <- as.POSIXct("2024-06-16 23:59:00")

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
vf_test_duplicates = duplicates_in_tb(vf_processed,"vf_processed")
sp_test_duplicates = duplicates_in_tb(sp_processed,"sp_processed")
cellphone_data <- merge_processed_celldata(vf_processed,sp_processed)
#browser()
#cellphone_data <- merge_cellphone_data(vp_resoved_duplicates,sp_resoved_duplicates)
#struct_df(cellphone_data,"cellphone_data",TRUE)