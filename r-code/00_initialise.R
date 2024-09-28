# 00_initilise.R file 
# takes each of our individual initialisation files 
# as per the document describing the detailed analysis and
# brings them together inth the a file as described in Taylor Winter's lecture. 
#
default_folder <- getwd()
cat("default folder:", default_folder, "\n")
# where are files reside. 
folder <- "r-code" 

# individual initial files
scripts <- c("000_initialise_DE.R", 
             "000_initialise_BD.R", 
             "000_initialise_MM.R", 
             "000_initialise_AB.R")

#  check for individual initialise files existence
for (script in scripts) {
  file_path <- file.path(folder, script)
  if (file.exists(file_path)) {
    # indicate script running
    cat(paste0("Running script:",default_folder,"/", file_path, "\n"))
    source(file_path) 
  } else {
    # indicate  the script does not exist
    cat(paste0("Script not found: ",default_folder,"/", file_path, "\n"))
  }
}

