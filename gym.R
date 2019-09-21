#----------------------------------------------------------------------------------#
# Inspects gym progress
# Author: Joel Becker

# Notes:
#   Takes google sheet containing 'date', 'exercise', 'weight' and 'sets'
#   Assume constant reps, give some formulas of progress and visualise
#----------------------------------------------------------------------------------#


########################################################
######################## Set-up ########################
########################################################

# load libraries
packages <- c("dplyr", "googledrive", "data.table", "ggplot2", "tidyr")
new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(packages, library, character.only = TRUE)
