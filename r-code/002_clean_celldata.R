# 002_clean_celldata.R



######################-celldata clean  functions ##############################################



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
# Add  columns has_NA and has_00:
#   has_NA - row having NA in the count
#   has_00 - row having zero in the count
#
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



##############################################################################
# remove  columns has_NA and has_00 
#
remove_NA0 <- function(tb) {
  if(DEEBUG_CELLDATA ==TRUE) cat("\n remove_NA0 \n")
  
  result <- tb %>%
    select(-has_NA, -has_00)  # Remove the has_NA and has_00 columns
  
  return(result)
}



##############################################################################
# remove columsn is_after_start and is before end
#
remove_istimed <- function(tb) {
  if(DEEBUG_CELLDATA ==TRUE) cat("\n remove_istimed \n")
  
  result <- tb %>%
    select(-is_after_start, -is_before_end)  # Remove the has_NA and has_00 columns
  
  return(result)
}

##############################################################################
# preprocess vf_data 
# the renaming is unnecessary at this point, however, 
# it makes things clear for the team. 
#
preprocess_vf_data <- function(tb) {
  if(DEEBUG_CELLDATA ==TRUE) cat("\n preprocess_vf_data \n")
  
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

##############################################################################
# preprocess sp_data
# the renaming is unnecessary at this point, however, 
# it makes things clear for the team. 
#
preprocess_sp_data <- function(tb) {
  if(DEEBUG_CELLDATA ==TRUE) cat("\n preprocess_sp_data \n")
  
  result <- tb %>%
    rename(datetime = ts)  %>%         # Rename 'dt' to 'datetime'
    rename(count = cnt)            # Rename 'dt' to 'datetime'
  #browser()
  result <- add_NA0(result) %>%  
    filter(has_NA == 0) %>%  
    filter(has_00 == 0) %>%  
    return(result)
}


##############################################################################
time_bound <- function(tb, time_start, time_end, tb_name = "") {
  # Filter and mutate the datetime column, convert it to NZST
  if(DEEBUG_CELLDATA ==TRUE) cat("\n time_bound \n")
  
  if (time_end < time_start) {
    cat("\n time_bound \n")
    cat("\nstart_time ", time_start,  " : ", as.numeric(time_start))
    cat("\nend_time   ", time_end,    " : ", as.numeric(time_end))
    return(NULL)
  }
  
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
    if(DEEBUG_CELLDATA ==TRUE){
      
      #browser()
      cat("time_bound() ", tb_name, ftime_start,"::", ftime_end )
      cat("\nclass(",tb_name,"):\n")
      print(class(result))
      cat("\nstart_time ", ftime_start,  " : ", as.numeric(time_start))
      cat("\nfirst()    ", fvalue0,      " : ", as.numeric(value0))
      cat("\nend_time   ", ftime_end,    " : ", as.numeric(time_end))
      cat("\nlast()     ", fvaluen,      " : ", as.numeric(valuen),"\n\n")
    }
  }
  return(result)
}

##############################################################################
merge_processed_celldata <- function(tb1, tb2) {
  if (DEEBUG_CELLDATA == TRUE) cat("\n merge_processed_celldata \n")
  
  # Perform the full join to retain all rows
  result <- tb1 %>%
    full_join(tb2, by = c("NZST", "sa2"), suffix = c(".tb1", ".tb2")) %>%  # Merge on 'NZST' and 'sa2'
    
    # Remove rows where one of the counts is missing
    filter(!is.na(count.tb1) & !is.na(count.tb2)) %>%
    
    # Sum the counts from both tibbles
    mutate(sum = count.tb1 + count.tb2) %>%
    
    # Select the necessary columns
    select(NZST, sa2, sum)
  
  return(result)
}


##############################################################################
sum_unique_duplicates <- function(tb, name = "not-specified") {
  if (DEEBUG_CELLDATA == TRUE) cat("\n sum_unique_duplicates(", name, "):\n")
  
  
  
  # Group by NZST and sa2, and sum only unique count values
  result <- tb %>%
    group_by(NZST, sa2) %>%
    distinct(count, .keep_all = TRUE) %>%  # for duplicates, keep only distinct `count` values
    summarise(count = sum(count), .groups = 'drop')  # Sum the unique count values
  
  # Print the result (optional)
  browser()
  print(result)
  
  return(result)
}


##############################################################################
has_duplicates <- function(tb, name = "not-specified") { 
  
  result <- tb %>%
    group_by(NZST, sa2) %>%
    summarise(duplicates = n(), .groups = "drop") %>%
    filter(duplicates > 1)
  
  # Check if result has rows
  if (nrow(result) == 0) {
    if (DEEBUG_CELLDATA == TRUE) { cat("\n has_duplicates (",name,") No duplicates found \n") }
    return(invisible(NULL))  # Exit if no duplicates
  }
  if (DEEBUG_CELLDATA == TRUE) { cat("\n has_duplicates (",name,") ",nrow(result)," duplicates found \n") }
  
  print(result)
  
  for (i in 1:nrow(result)) {
    v_dt  <- result$NZST[i]
    v_sa2 <- result$sa2[i]
    
    # Print only unique rows by 'count'
    cat("\nUnique rows in", name, ", datetime =", v_dt, "and sa2 =", v_sa2, ":\n")
    unique_rows <- tb %>%
      filter(NZST == v_dt & sa2 == v_sa2) %>%
      distinct(count, .keep_all = TRUE)   # Keep only distinct 'count' values
    
    print(unique_rows)
  }
}


##############################################################################
process_duplicates <- function(tb, name = "not-specified") {
  if (DEEBUG_CELLDATA == TRUE) { 
    cat("=====================================================")
    cat("\n process_duplicates(",name,")\n") 
  }
  result <- tb %>%
    group_by(NZST, sa2) %>%                           # Group by NZST and sa2, 
    summarise(duplicates = n(), .groups = "drop") %>% 
    filter(duplicates > 1)
  
  # If no duplicates are found
  if (nrow(result) == 0) {
    cat("No duplicates found in", name, "\n")
    return(tb)  # Return the original dataframe 
  }
  
  # Limit to the first 5 duplicate sets for printing
  first_5_duplicates <- head(result, 5)
  
  # Show the process for the first 5 duplicates
  if (DEEBUG_CELLDATA == TRUE) for (i in 1:nrow(first_5_duplicates)) {
    v_dt  <- first_5_duplicates$NZST[i]
    v_sa2 <- first_5_duplicates$sa2[i]
    
    # Print only unique rows by 'count'
    cat("\nUnique rows in", name, ", datetime =", v_dt, "and sa2 =", v_sa2, ":\n")
    unique_rows <- tb %>%
      filter(NZST == v_dt & sa2 == v_sa2) %>%
      distinct(count, .keep_all = TRUE)  # Keep only distinct 'count' values
    
    print(unique_rows)  # Print the unique rows
    
    # Apply sum_unique_duplicates to the unique rows
    cat("\nSumming unique counts for", name, ", datetime =", v_dt, "and sa2 =", v_sa2, ":\n")
    summed_result <- sum_unique_duplicates(unique_rows, name)
    print(summed_result)  # Print the summed result
  }
  
  # Now deduplicate the entire dataframe
  deduplicated_tb <- tb %>%
    group_by(NZST, sa2) %>%
    distinct(count, .keep_all = TRUE) %>%  # Keep only distinct count values
    summarise(count = sum(count), .groups = "drop")  # Sum the unique counts
  
  return(deduplicated_tb)  # Return the deduplicated dataframe
}



##############################################################################

# Function to sum only unique duplicates
sum_unique_duplicates <- function(tb, name = "not-specified") {
  if (DEEBUG_CELLDATA == TRUE) { cat("\n sum_unique_duplicates(", name, "):\n") }
  
  # Group by NZST and sa2, and sum only unique count values
  result <- tb %>%
    group_by(NZST, sa2) %>%
    distinct(count, .keep_all = TRUE) %>%            # Keep  distinct `count` values
    summarise(count = sum(count), .groups = 'drop')  # Sum the unique count values
  
  return(result)
}
