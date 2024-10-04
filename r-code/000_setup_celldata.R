# File: 000_setup_celldata.R

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
if(!require(conflicted)) {
  install.packages("conflicted")}



library(tidyverse)
library(tools)
library(arrow)  
library(vroom)
library(readr)

#browser()

conflict_prefer("filter", "dplyr",quiet=TRUE) 
conflict_prefer("problems", "vroom",quiet=TRUE) 


# for analysis only 
source("./test/analyse-celldata-structure.R")