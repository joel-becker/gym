#----------------------------------------------------------------------------------#
# Plots gym data
# Author: Joel Becker

# Notes:
#   Takes google sheet containing 'date', 'exercise', 'weight' and 'sets'
#   Assume constant reps, give some formulas of progress and visualise
#----------------------------------------------------------------------------------#


########################################################
######################## Set-up ########################
########################################################

# load libraries
packages <- c("dplyr", "data.table", "ggplot2", "tidyr")
new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(packages, library, character.only = TRUE)

# numbers to calibrate intensity metrics
AR <- 0.4
MA <- 0.8
aerobic_intensity <- 2
compound_intensity <- 1.3
almost_compound_intensity <- 1.1
sets_exponent <- 0.6
exercise_exponent <- 0.6


########################################################
##################### Wrangle data #####################
########################################################

wrangle.intensity.metrics <- function(data = data) {
  # compute intensity metrics (for within- and between-exercise comparisons)

  data <- data %>%

    # create arbitrary intensity measure
    mutate(intensity = weight * (sets^sets_exponent)) %>%

    # intensity wrangling by exercise
    group_by(exercise) %>%
    mutate(
      # mean intensity of each exercise
      mean_intensity = mean(intensity),
      # index intensity to first exercise for each exercise
      index_intensity = intensity / first(intensity)
    ) %>%
    ungroup() %>%

    # intensity wrangling by exercise type
    mutate(
      # normalise intensity
      normalise_intensity = intensity / mean_intensity,
      # weight intensity measure by exercise type
      weight_intensity = case_when(
        exercise %in% aerobic         ~ normalise_intensity * aerobic_intensity,
        exercise %in% compound        ~ normalise_intensity * compound_intensity,
        exercise %in% almost_compound ~ normalise_intensity * almost_compound_intensity,
        TRUE                          ~ normalise_intensity
      )
    )

  return(data)
}

wrangle.time.metrics <- function(data = data) {
  # format dates and set up date-location metrics for intensity comparisons over time

  data <- data %>%

    mutate(
      # format dates
      date = as.Date(date, "%m/%d/%Y"),

      # create gym/not-gym indicator
      location = case_when(
        exercise %in% aerobic ~ "aerobic",
        TRUE                  ~ "gym"
      )
    ) %>%

    # intensity by date
    group_by(date) %>%
    mutate(n_exercise_bydate = n(),
           intensity_bydate  = sum(weight_intensity) / (n_exercise_bydate^exercise_exponent)) %>%
    ungroup() %>%

    # intensity by date and location
    group_by(date, location) %>%
    mutate(
      n_exercise_bydatelocation = n(),
      intensity_bydatelocation  = sum(weight_intensity) / (n_exercise_bydatelocation^exercise_exponent)
    ) %>%
    ungroup() %>%

    # index intensity-time metrics to first instance of exercise
    group_by(location) %>%
    mutate(
      index_intensity_bydate         = intensity_bydate         / first(intensity_bydate),
      index_intensity_bydatelocation = intensity_bydatelocation / first(intensity_bydatelocation)
    ) %>%
    arrange(date) %>%
    mutate(
      cummax_index_intensity_bydate         = cummax(index_intensity_bydate),
      cummax_index_intensity_bydatelocation = cummax(index_intensity_bydatelocation)
    ) %>%
    ungroup()

  return(data)
}
