# File: test-celldata-structure.R
#library(rstudioapi)
#print(rstudioapi::getSourceEditorContext()$path)

#browser()
source("./test/analyse-celldata-structure.R")

#browser()
df_list1 <- list(
  vf_data        = vf_data,
  vf_prep        = vf_prep,
  vf_timed       = vf_timed,
  vf_processed   = vf_processed, 
  cellphone_data = cellphone_data
  )
df_list2 <- list(
  sp_data        = sp_data,
  sp_prep        = sp_prep,
  sp_timed       = sp_timed,
  sp_processed   = sp_processed,
  cellphone_data = cellphone_data
  )

df_list3 <- list(
  vf_data       = vf_data,
  sp_data       = sp_data,
  vf_prep       = vf_prep, 
  sp_prep       = sp_prep, 
  vf_timed      = vf_timed,
  sp_timed      = sp_timed, 
  vf_processed  = vf_processed, 
  sp_processed  = sp_processed, 
  cellphone_data = cellphone_data
)

#browser()
show_tb_structure(df_list1)
show_tb_structure(df_list2)
show_tb_structure(df_list3)

 

