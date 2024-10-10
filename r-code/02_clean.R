# 02_clean.R

######################Cleaning SA2_2023 and Subnational population estimate data###############
source("./r-code/002_clean_files_BD.R")




######################Cleaning SA2 and Urban Rural Indicator###################################
source("./r-code/002_clean_files_MM.R")



######################-celldata clean  functions ##############################################
#
source("./r-code/002_clean_celldata.R")

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
# REQUIRED TIME VALUES  (this may need to be in run.R)
# REQUIRED TIME VALUES  (this may need to be in run.R)
#
#normal_week_start  <- as.POSIXct("2024-06-03 00:00:00", tz = "Pacific/Auckland")
#normal_week_stop   <- as.POSIXct("2024-06-09 23:59:59", tz = "Pacific/Auckland")
#holiday_week_start <- as.POSIXct("2024-06-10 00:00:00", tz = "Pacific/Auckland")
#holiday_week_stop  <- as.POSIXct("2024-06-16 23:59:00", tz = "Pacific/Auckland")

vf_prep = preprocess_vf_data(vf_data)
sp_prep = preprocess_sp_data(sp_data)
#browser()
vf_timed = time_bound(vf_prep, tb_name = "vf_timed",normal_week_start,holiday_week_stop)
sp_timed = time_bound(sp_prep, tb_name = "sp_timed",normal_week_start,holiday_week_stop)

#browser()
vf_timed <- remove_NA0(vf_timed)
sp_timed <- remove_NA0(sp_timed)

#browser()
vf_timed <- remove_istimed(vf_timed)
sp_timed <- remove_istimed(sp_timed)

#browser()
vf_processed <- process_duplicates(vf_timed,"vf_timed")
sp_processed <- process_duplicates(sp_timed,"sp_timed")

#browser()
cellphone_data <- merge_processed_celldata(vf_processed,sp_processed)
#
#
######################-celldata clean  functions ##############################################




