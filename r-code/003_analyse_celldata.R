
#library(rstudioapi)
#print(rstudioapi::getSourceEditorContext()$path)
#browser() 
# 002_clean_celldata.R



######################-celldata analytical functions ###########################


# 002_clean_cellphone_data.R
# 
# This set of functions are provided to do the following:
# 


# from my analysis:
#----------------------------------------
# vf_data:  [1] "dt   : POSIXct POSIXt"
# sp_data:  [1] "ts   : POSIXct POSIXt"
#
# BOTH columns are POSIXct. 
#
# Will use the name:
#
# 'datetime' as the resulting column name  
#            merged column and will be POSIXct
#----------------------------------------
# vf_data:  [1] "area : character"
# sp_data:  [1] "sa2  : numeric"
#
# ONE columns are NOT numeric.
#
# Will use the name:
#
# 'sa2'      as the resulting column name  
#            merged column and will be numeric.
#
#----------------------------------------
# vf_data:  [1] "devices : numeric"
# sp_data:  [1] "cnt     : numeric"
# 
# BOTH columns are numeric
#
# Will use the name:
#
# 'count'   as the resulting column name 
#           The value is the sum: 
#           vf_data$devices + sp_data$cnt
#
#========================================
#  file: ./data/vf_data.parquet 
#----------------------------------------
#  read_parquet
#
# class( ./data/vf_data.parquet ):
#  [1] "tbl_tb"     "tbl"        "data.frame"
#
# class for each of  3 columns:
# [1] "dt      : POSIXct POSIXt"
# [1] "area    : character"
# [1] "devices : numeric"
#  A tibble: 10 × 3
#    dt                  area   devices
#    <dttm>              <chr>    <dbl>
#  1 2024-06-03 00:00:00 100100    340.
#  2 2024-06-03 01:00:00 100100    318.
#  3 2024-06-03 02:00:00 100100    528. 
#========================================

#========================================
#  file: ./data/sp_data.csv.gz 
#----------------------------------------
#  vroom
# A tibble: 0 × 5                                        
# ℹ 5 variables: row <int>, col <int>, expected <chr>,
#   actual <chr>, file <chr>
#----------------------------------------
#  
#  class( ./data/sp_data.csv.gz ):
#  [1] "spec_tbl_tb" "tbl_tb"      "tbl"         "data.frame" 
#
# class for each of  3 columns:
# [1] "ts  : POSIXct POSIXt"
# [1] "sa2 : numeric"
# [1] "cnt : numeric"
#  A tibble: 10 × 3
#    ts                   sa2   cnt
#    <dttm>               <dbl> <dbl>
#  1 2024-06-02 12:00:00 100100  793.
#  2 2024-06-02 13:00:00 100100  742.
#  3 2024-06-02 14:00:00 100100 1233. 
#=========================================



##############################################################################
# get_cell_plotdata
#
get_cell_plotdata <- function(tb, sa, time_start, time_stop) {
  
  time_max = .Machine$integer.max
  browser()
  if (time_start > time_stop) {
    return(invisible(NULL))  # time range invalid
  }
  
  # tb rows within the time range (inclusive)
  filtered_tb <- tb %>%
    filter(NZST >= time_start & NZST <= time_stop)
  
  #  join between the filtered tb and sa based on the  SA and SA2 columns match
  #  group by NZST and calculate the sum of the 'sum' column from tb
  result <- filtered_tb %>%
    inner_join(sa, by = c("SA2" = "sa2"))
  
#  %>%    # Join on matching SA and SA2 columns
#    group_by(NZST) %>%                         # Group by NZST (time)
#    summarise(SA2 = min(SA2),                     # Keep the minimum SA value for each group
#S              total_sum = sum(sum))             # Sum the 'sum' column for each time entry
  
  return(result)  # Return the resulting tibble
}
