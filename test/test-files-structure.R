# File: test-datafile-structure.R
#library(rstudioapi)
#print(rstudioapi::getSourceEditorContext()$path)

source("./test/analyse-data-structure.R")


#my list of files, you may have a differnt one. 
#files <- c("20241001.clean-sa2_2023.csv", 
#           "20241001.clean-sa2_ta_concord_data.csv",  
#           "20241001.clean-subnational_pop_ests.csv", 
#           "20241001.clean-urban_rr_indicator_data.csv",  
#           "20241001.urban_rural_to_sa2_concord_2023.csv")
files <- c( "sa2_2023.csv", 
            "sa2_ta_concord_2023.csv", 
            "sp_data.csv.gz",
            "subnational_pop_ests.csv", 
            "urban_rural_to_indicator_2023.csv", 
            "urban_rural_to_sa2_concord_2023.csv",
            "vf_data.parquet"
           )
#fileset1 <-  c("sp_data.csv.gz", "20241001.clean-sp_data.csv", "20241001.sp_data.rds")
#fileset2 <-  c("vf_data.parquet","20241001.clean-vf_data.csv", "20241001.vf_data.rds")
#fileset1 <-  c("20241001.clean-sa2_2023.csv", "sa2_2023.csv")
#fileset2 <-  c("20241001.clean-sa2_ta_concord_data.csv", "sa2_ta_concord_data.csv")
#fileset4 <-  c("20241001.clean-subnational_pop_ests.csv", "subnational_pop_ests.csv")
#fileset5 <-  c("20241001.clean-urban_rr_indicator_data.csv", "urban_rr_indicator_data.csv")
#fileset7 <-  c("20241001.urban_rural_to_sa2_concord_2023.csv", "urban_rural_to_sa2_concord_2023.csv")


show_file_structure(files) 
#cat("========================================\n")
#show_file_structs(fileset1) 
#show_file_structs(fileset2) 
#show_file_structs(fileset3) 
#show_file_structs(fileset4) 
#show_file_structs(fileset5) 
#show_file_structs(fileset6) 
#show_file_structs(fileset7) 
cat("========================================\n")


