# 01_import.R
#
# Once you merge, run .test/INTEGRATION_TEST_celldata.R to ensure celldata 
# is still working
#
# Also, write your own Integration test and PUT ITS NAME HERE so we can 
# ensure we dont affect your work 
#
#

  

######################-Somebody elses code -###################################################
source("./r-code/000_read_files_BD.R")
#ignore parsing issue

######################sa2_ta_concord and urban_rural_to_indicator files#######

source("./r-code/000_initialise_MM.R")


sa2_ta_concord = read_sa2_ta_concord()
urban_rr_indicator = read_urban_rural_indicator()

######################-celldata import functions ##############################################
#
#
#

source("./r-code/001_import_celldata.R")

vf_data = read_VF_parquet()
sp_data = read_SP_gz()

#
#
#
######################-celldata import functions ##############################################
