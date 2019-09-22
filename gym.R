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
