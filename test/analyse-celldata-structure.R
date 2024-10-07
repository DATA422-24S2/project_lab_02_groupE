# File: analyse-celldata-structure.R
# NOTE: 
# NOTE: 
# NOTE: This script is created to allow for analysis of the celldata structures.
# NOTE: Although this is provided for use by the team, I recommend you make 
# NOTE: a different version to tailor for working on other structures. This 
# NOTE: script is meant to be standalone and not sourced in other scripts. 
# NOTE: 
# NOTE: 

#library(rstudioapi) 
#print(sys.frame(1)$ofile)
if(!require(arrow)) {
  install.packages("arrow")}
if(!require(vroom)) {
  install.packages("vroom")}
if(!require(dplyr)) {
  install.packages("tidyverse")}
if(!require(readr)) {
install.packages("readr")}


library(dplyr)
library(arrow)  
library(vroom)

get_tb_names <- function(tb_list) {
  names_list <- sapply(substitute(tb_list)[-1], deparse)
  return(names_list)
}

struct_df <- function(x, folder = "./data", print_tail = TRUE, saveas_RDS = FALSE,tb_name="not-specified") {  # what is the structure of a dataframe?
  cat("\n struct_df \n")
  
  #browser()
  cat("\nclass(",tb_name,"):\n")
  print(class(x))
  #browser()
  n <- ncol(x)
  l <- max(nchar(colnames(x)))
  cat("\nclass for each of ",n,"columns:\n")
  for (i in 1:n) {
    
    column_name  <- colnames(x)[i]
    column_class <- class(pull(x, i))  # Directly get the class of the column
    # print(paste( column_name, ":", column_class))
    print(sprintf("%-*s : %s", l, column_name, paste(column_class, collapse = " ")))
  }
  
  #----------------------------------------
  # PRINT_TAIL
  #
  if(print_tail == FALSE){
    print(head(x, n = 10))
  } else {
    cat("\nhead:\n")
    print(head(x, n = 10))
    cat("\ntail:\n")
    print(tail(x, n = 10))
  # browser()
  }
  
  #----------------------------------------
  # SAVEAS_RDS
  #
  save_RDS <- (saveas_RDS == TRUE) && (tb_name != "")
# browser()
  if(save_RDS){
#   rds_file <- paste0(format(Sys.Date(), "%Y%m%d"),".",tb_name,".RDS")
    rds_file <- paste0(as.numeric(Sys.time()), ".", tb_name, ".RDS")
    rds_file <- file.path(folder, rds_file)
#   browser()
    saveRDS(x,rds_file)
    cat(rds_file, " :saved\n")
  }
# browser()
}

struct_file <- function(filename,df_name = "") {  # what is the structure in the file? 
  if(DEEBUG_CELLDATA ==TRUE) cat("\n struct_file \n")
  
  #browser()
  cat("========================================\n")
  cat("file:",filename,"\n")
  #browser()
  ext <- toupper(tools::file_ext(filename))
  x = NULL
  if (ext %in% c("GZ", "CSV")){ 
    cat("----------------------------------------\n")
    cat("vroom\n")
    browser()
    x <- suppressWarnings(vroom(filename, show_col_types = FALSE))
    issues <- suppressWarnings(problems(x))
    suppressWarnings(print(issues))
    #browser()
    cat("----------------------------------------\n")
  } 
  if(ext=="RDS")    {
    x = read_rds(filename)
    cat("----------------------------------------\n")
    cat("read_rds\n")
  } 
  if(ext=="PARQUET") {
    x = read_parquet(filename)
    cat("----------------------------------------\n")
    cat("read_parquet\n")
  }
  if (is.null(x)) {
    cat("\n",filename,"\n")

    cat("\n",filename, " is NOT a filetype for this analysis\n")
  } else { 
    struct_df(x,saveas_RDS = TRUE)
  }
}

show_file_structs <- function(files) {  
  if(DEEBUG_CELLDATA ==TRUE) print("show_file_structs\n")
  
  folder <- "./data" 
  for (file in files) {
    #
    file_path <- file.path(folder, file)
    #browser()
    if (file.exists(file_path)){struct_file(file_path)
    } else {
      cat("========================================\n")
      cat("FILE DOES NOT EXIST: ",file_path,"\n")
      cat("FILE DOES NOT EXIST: ",file_path,"\n")
      cat("========================================\n")
      } 
    #browser()
  }
}

show_tb_structure <- function(tb_list){
  #browser()
  
  # If tb_list already has names, you can use them directly
  if (is.null(names(tb_list))) {
    stop("The list of dataframes must have names.")
  }
  
  # Loop through the list and apply struct_df to each dataframe
  for (i in seq_along(tb_list)){
    tb_name <- names(tb_list)[[i]]  # Get the name of the dataframe
    struct_df(tb_list[[i]], print_tail = TRUE, tb_name= tb_name)  
  }
}




