# 00_initialse.R
#
# Once you merge, run .test/INTEGRATION_TEST_celldata.R to ensure celldata is still working
#
#

if(!require(dplyr)) {
  install.packages("tidyverse")}
if(!require(tools)) {
  install.packages("tools")}
if(!require(arrow)) {
  install.packages("arrow")}
if(!require(vroom)) {
  install.packages("vroom")}
if(!require(readr)) {
  install.packages("readr")}
if(!require(dplyr)) {
  install.packages("dplyr")}
if(!require(lubridate)) {
  install.packages("lubridate")}
if(!require(conflicted)) {
  install.packages("conflicted")}
 

library(tidyverse)
library(tools)
library(arrow)  
library(vroom)
library(readr)
library(dplyr)
library(lubridate)


#browser()

conflict_prefer("filter", "dplyr",quiet=TRUE) 
conflict_prefer("problems", "vroom",quiet=TRUE) 

# global variables 
DEEBUG_CELLDATA <- FALSE # NORMAL OPERATION, SET TO TRUE FOR DEBUGGING. 

folder_data   <- "./data/"
folder_map    <- "./map/"
file_celldata <- "assignment.celldata.RDS"

# for analysis only 
# source("./test/analyse-celldata-structure.R")
