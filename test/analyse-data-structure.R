# File: analyse-datafile-structure.R
# NOTE: 
# NOTE: 
# NOTE: Although this is provided for use by the team, I recommend you make your
# NOTE: own version of this as I am tailoring this to the files I work on
# NOTE: and it may not work in a generic case in the future. 
# NOTE: 
# NOTE: 
# NOTE: 


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

struct_df <- function(x,name="not-specified", print_tail = FALSE) {  # what is the structure of a dataframe? 
  #browser()
  cat("\nclass(",name,"):\n")
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
  if(print_tail == FALSE){
    print(head(x, n = 10))
  } else {
    print(head(x, n = 10))
    print(tail(x, n = 10))
  }
}

struct_file <- function(name) {  # what is the structure in the file? 
  cat("========================================\n")
  cat("file:",name,"\n")
  #browser()
  ext <- toupper(tools::file_ext(name))
  x = NULL
  if (ext %in% c("GZ", "CSV")){ 
    cat("----------------------------------------\n")
    cat("vroom\n")
    x <- suppressWarnings(vroom(name, show_col_types = FALSE))
    issues <- suppressWarnings(problems(x))
    suppressWarnings(print(issues))
    #browser()
    cat("----------------------------------------\n")
  } 
  if(ext=="RDS")    {
    x = read_rds(name)
    cat("----------------------------------------\n")
    cat("read_rds\n")
  } 
  if(ext=="PARQUET") {
    x = read_parquet(name)
    cat("----------------------------------------\n")
    cat("read_parquet\n")
  }
  if (is.null(x)) {
    cat("\n",name,"\n")

    cat("\n",name, " is NOT a filetype for this analysis\n")
  } else { 
    struct_df(x,name)
    
  }
}

show_file_structs <- function(files) {
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





