#----------------------------------------------------------------------------------#
# Functions for downloading and recosnising data
# Author: Joel Becker

# Notes:
#
#----------------------------------------------------------------------------------#


########################################################
######################## Set-up ########################
########################################################

# load libraries
packages <- c("data.table")
new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(packages, library, character.only = TRUE)


########################################################
####################### Functions ######################
########################################################

display.missing.exercise <- function(exercise_data, exercise_classes) {
  # displays exercise which occur in inputted data but are not recognised by program

  input_exercises <- exercise_data[, "exercise"]
  missing_exercises <- input_exercises[!(input_exercises %in% exercise_classes)]

  warning_message <- paste0(
    "WARNING: charts will contain incorrectly grouped exercises, ",
    "as the following exercises are not recognised by the program:",
    "\t",
    missing_exercises,
    "\n"
    )

  return(warning_message)
}

download.data <- function(file_name = "exercise_data", file_format = "csv") {
  # downloads and returns data from google drive

  drive_download(file_name, type = file_format, overwrite=TRUE)
  path <- paste0(file_name, ".", file_format)
  data <- fread(path)

  return(data)
}
