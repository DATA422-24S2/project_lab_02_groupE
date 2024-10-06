

#
# missing at this point:
#
#  * resolution for duplicates 
#  * merging VF and SP data to one dataframe containing clean and summed data
#
#  expected to complete on Wednesday of this week. 
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




# This set of functions are provided to do the following:
# 
#library(rstudioapi)
#calls <- sys.calls()
#print(sys.calls()[sapply(calls, function(x) "source" %in% as.character(x))])
# Filter only for 'source' calls

#browser()

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
  if(DEEBUG_CELLDATA ==TRUE) cat("\n add_NA0 \n")
  
  result <- tb %>%
    mutate(
      
      has_NA = as.numeric(is.na(.[[3]])),  # 1 if NA in 3rd column
      has_00 = as.numeric(.[[3]] == 0)     # 1 if 0 in 3rd column
    )
  #browser()
  return(result)
}

remove_NA0 <- function(tb) {
  if(DEEBUG_CELLDATA ==TRUE) cat("\n remove_NA0 \n")
  
  result <- tb %>%
    select(-has_NA, -has_00)  # Remove the has_NA and has_00 columns
  
  return(result)
}

remove_istimed <- function(tb) {
  if(DEEBUG_CELLDATA ==TRUE) cat("\n remove_istimed \n")
  
  result <- tb %>%
    select(-is_after_start, -is_before_end)  # Remove the has_NA and has_00 columns
  
  return(result)
}

# preprocess vf_data 
# the renaming is unnecessary at this point, however, 
# it makes things clear for the team. 
preprocess_vf_data <- function(tb) {
  if(DEEBUG_CELLDATA ==TRUE) cat("\n preprocess_vf_data \n")
  
  result <- tb %>%
    rename(sa2 = area) %>%             # Rename 'area' to 'sa2' 
    mutate(sa2 = as.numeric(sa2)) %>%  # Convert 'sa2' (renamed) to numeric - required
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
  if(DEEBUG_CELLDATA ==TRUE) cat("\n preprocess_sp_data \n")
  
  result <- tb %>%
    rename(datetime = ts)  %>%     # Rename 'dt' to 'datetime'
    rename(count = cnt)            # Rename 'dt' to 'datetime'
  #browser()
  result <- add_NA0(result) %>%  
    filter(has_NA == 0) %>%  
    filter(has_00 == 0) %>%  
    return(result)
}


time_bound <- function(tb, time_start, time_end, tb_name = "") {
  # Filter and mutate the datetime column, convert it to NZST
  if(DEEBUG_CELLDATA ==TRUE) cat("\n time_bound \n")
  
  result <- tb %>%
    filter(datetime >= time_start & datetime <= time_end) %>%
    mutate(datetime = with_tz(datetime, "Pacific/Auckland")) %>%
    
    rename(NZST = datetime) 
  
  result <- result %>%
    mutate(
      is_after_start = as.numeric(NZST >= time_start), 
      is_before_end  = as.numeric(NZST <= time_end)     
    )
  
  if(tb_name != ""){
    #browser()
    
    # Capture the first and last row of the datetime column safely
    value0      <- result %>% pull(NZST) %>% first() 
    valuen      <- result %>% pull(NZST) %>% last() 
    fvalue0     <- format(result %>% pull(NZST) %>% first(), "%Y-%m-%d %H:%M:%S")  
    fvaluen     <- format(result %>% pull(NZST) %>% last() , "%Y-%m-%d %H:%M:%S")
    ftime_start <- format(time_start                       , "%Y-%m-%d %H:%M:%S")  
    ftime_end   <- format(time_end                         , "%Y-%m-%d %H:%M:%S")
    
    # Output for debugging
    #browser()
    cat("time_bound() ", tb_name, ftime_start,"::", ftime_end )
    cat("\nclass(",tb_name,"):\n")
    print(class(result))
    cat("\nstart_time ", ftime_start,  " : ", as.numeric(time_start))
    cat("\nfirst()    ", fvalue0,      " : ", as.numeric(value0))
    cat("\nend_time   ", ftime_end,    " : ", as.numeric(time_end))
    cat("\nlast()     ", fvaluen,      " : ", as.numeric(valuen),"\n\n")
  }
  return(result)
}





