#----------------------------------------------------------------------------------#
# Master script for downloading, checking, wrangling and plotting gym data
# Author: Joel Becker

# Notes:
#
#----------------------------------------------------------------------------------#


########################################################
#################### Load libraries ####################
########################################################

packages <- c("dplyr", "data.table", "ggplot2", "tidyr")
new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(packages, library, character.only = TRUE)


########################################################
################### Source functions ###################
########################################################

# downloading and checking
source("download_data.R")

# exercise-classification
source("class_exercises.R")

# wrangling
source("wrangle_data.R")

# plotting
source("plot_data.R")


########################################################
########### Download, check and wrangle data ###########
########################################################

data <- download.data() %>%
  display.missing.exercise(., exercise_classes = exercise_classes) %>%
  wrangle.intensity.metrics() %>%
  wrangle.time.metrics()


########################################################
############### Prepare and produce plots ##############
########################################################

time_chart <- data %>%
  wrangle.time.chart() %>%
  plot.time.chart()

workout_chart <- data %>%
  wrangle.workout.chart() %>%
  plot.workout.chart()

exercise_chart <- data %>%
  wrangle.exercise.chart() %>%
  plot.exercise.chart()


########################################################
###################### Save plots ######################
########################################################

ggsave("time.png",     time_chart,     width = 16, height = 9)
ggsave("workout.png",  workout_chart,  width = 16, height = 9)
ggsave("exercise.png", exercise_chart, width = 16, height = 9)
