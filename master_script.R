#----------------------------------------------------------------------------------#
# Master script for downloading, checking, wrangling and plotting gym data
# Author: Joel Becker

# Notes:
#
#----------------------------------------------------------------------------------#


########################################################
######################## Set-up ########################
########################################################

# load libraries
packages <- c("dplyr", "data.table", "ggplot2", "tidyr")
new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(packages, library, character.only = TRUE)


########################################################
################### Source functions ###################
########################################################

# downloading and checking functions
source("download_data.R")

# exercise-classification functions
source("download_data.R")

# wrangling functions
source("download_data.R")

# plotting functions
source("download_data.R")
