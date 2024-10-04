# 002_clean_cellphone_data.R
#library(rstudioapi)
#calls <- sys.calls()
#print(sys.calls()[sapply(calls, function(x) "source" %in% as.character(x))])
# Filter only for 'source' calls

browser()

# Print the filtered source calls
#print(source_calls)

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
#  4 2024-06-03 03:00:00 100100    411.
#  5 2024-06-03 04:00:00 100100    486.
#  6 2024-06-03 05:00:00 100100    284.
#  7 2024-06-03 06:00:00 100100    208.
#  8 2024-06-03 07:00:00 100100    416.
#  9 2024-06-03 08:00:00 100100    359.
# 10 2024-06-03 09:00:00 100100    380.
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
#  4 2024-06-02 15:00:00 100100  959.
#  5 2024-06-02 16:00:00 100100 1134.
#  6 2024-06-02 17:00:00 100100  663.
#  7 2024-06-02 18:00:00 100100  485.
#  8 2024-06-02 19:00:00 100100  970.
#  9 2024-06-02 20:00:00 100100  837.
# 10 2024-06-02 21:00:00 100100  887.
#=========================================



# Add  columns has_NA and has_00
add_NA0 <- function(tb) {
  result <- tb %>%
    mutate(
      
      has_NA = as.numeric(is.na(.[[3]])),  # 1 if NA in 3rd column
      has_00 = as.numeric(.[[3]] == 0)     # 1 if 0 in 3rd column
    )
  #browser()
  return(result)
}

# preprocess vf_data 
# the renaming is unnecessary at this point, however, 
# it makes things clear for the team. 
preprocess_vf_data <- function(tb) {
  result <- tb %>%
    rename(sa2 = area) %>%             # Rename 'area' to 'sa2'
    mutate(sa2 = as.numeric(sa2)) %>%  # Convert 'sa2' (renamed) to numeric
    rename(datetime = dt)  %>%         # Rename 'dt' to 'datetime'
    rename(count = devices)            # Rename 'dt' to 'datetime'
  
  #browser()
  result <- add_NA0(result) %>%  
    filter(has_NA == 0) %>%  
    filter(has_00 == 0) %>%  
    return(result)
}
# preprocess sp_data
# the renaming is unnecessary at this point, however, 
# it makes things clear for the team. 
preprocess_sp_data <- function(tb) {
  result <- tb %>%
    rename(datetime = ts)  %>%         # Rename 'dt' to 'datetime'
    rename(count = cnt)            # Rename 'dt' to 'datetime'
  #browser()
  result <- add_NA0(result) %>%  
    filter(has_NA == 0) %>%  
    filter(has_00 == 0) %>%  
    return(result)
}



# time bound one of the preprocessed tibbles 
#
time_bound <- function(tb, start_time, end_time) {
  result <- tb %>%
    filter(datetime >= start_time & datetime <= end_time)
  
  return(result)
}
  

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

normal_week_start  <- as.POSIXct("2024-06-03 00:00:00")
normal_week_stop   <- as.POSIXct("2024-06-09 23:59:59")
holiday_week_start <- as.POSIXct("2024-06-10 00:00:00")
holiday_week_stop  <- as.POSIXct("2024-06-16 23:59:00")


merge_cellphone_data <- function(tb1, tb2) {
  browser()
  result <- tb1 %>%
    inner_join(tb2, by = c("datetime", "sa2")) %>%  # where 'datetime' and 'sa2' match 
    mutate(sum = tb1$count + tb2$count) %>%         # Sum the counts
    select(datetime, sa2, sum)                      #  'datetime', 'sa2', and new 'sum' column
  
  return(result)
}

duplicates_in_tb <- function(tb, name = "not-specified") {
  cat("\nduplicates_in_tb(",name,"):\n")
  result <- tb %>%
    group_by(datetime, sa2) %>%
    summarise(duplicates = n()) %>%
    filter(duplicates > 1)
  browser()
  print(result)
  browser()
  for (i in 1:nrow(result)) {
    v_dt  <- result$datetime[i]
    v_sa2 <- result$sa2[i]
    browser()
    # Print the filtered rows 
    # cat("\nRows in", name, "for datetime =", v_dt, "and sa2 =", v_sa2, ":\n")
    # print(tb %>% filter(datetime == v_dt & sa2 == v_sa2))
    
    # Print only unique rows by 'count' 
    cat("\nUnique rows in", name, ", datetime =", dt_val, "and sa2 =", sa2_val, ":\n")
    unique_rows <- tb %>%
      filter(datetime == dt_val & sa2 == sa2_val) %>%
      distinct(count, .keep_all = TRUE)   # Keep only distinct 'count' values
    print(unique_rows)
  }
}












































