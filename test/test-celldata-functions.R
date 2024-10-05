#test-celldata-functions.R
#library(rstudioapi)
#print(rstudioapi::getSourceEditorContext()$path)
#
#
# This file is exclusively for detailed analysis of the celldata functions
#
#

browser()
source("./r-code/00_initialise.R")
source("./r-code/01_import.R")
source("./test/002_clean_celldata.R")
source("./r-code/003_analyse_celldata.R")
source("./r-code/004_visualise_celldata.R")
source("./test/analyse-celldata-structure.R")


browser()
vf_data = read_VF_parquet()              ## performed in  ./r-code/01_import.R
struct_df(vf_data,"vf_data",saveas_RDS = TRUE)
vf_prep = preprocess_vf_data(vf_data)
struct_df(vf_prep,"vf_prep")


sp_data = read_SP_gz()                   ## performed in  ./r-code/01_import.R
struct_df(sp_data,"sp_data")
snp_prep = preprocess_sp_data(sp_data)
struct_df(sp_prep,"sp_prep")
browser()

vf_timed = time_bound(vf_prep,normal_week_start,holiday_week_stop)
sp_timed = time_bound(sp_prep,normal_week_start,holiday_week_stop)
struct_df(vf_timed,"vf_timed",TRUE)
struct_df(sp_timed,"sp_timed",TRUE)
browser()
# Check for duplicates 
duplicates_in_tb(vf_timed,"vf_timed")
duplicates_in_tb(sp_timed,"sp_timed")
browser()
cellphone_data <- merge_cellphone_data(vf_timed,sp_timed)
struct_df(cellphone_data,"cellphone_data",TRUE)