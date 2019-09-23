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

wrangle.time.chart <- function(data = data) {
  # generates decaying curve of exercise intensity over time

  # obtain list of dates from first exercise until present
  dates <- data.frame(date = seq.Date(min(data$date), Sys.Date(), 1))

  # summarise decaying exercise intensity over these dates
  data <- data %>%

    # join intensity data to dates
    right_join(dates, by = "date") %>%

    # summarise one row per date
    group_by(date) %>%
    summarise(
      intensity_bydate         = mean(intensity_bydate),
      intensity_bydatelocation = mean(intensity_bydatelocation)
      ) %>%
    ungroup() %>%

    # compute decaying sum of intensity over time
    mutate(
      # correct for zero-exercise days
      intensity_bydate = case_when(
        is.na(intensity_bydate) ~ 0,
        TRUE                    ~ intensity_bydate
        ),
      intensity_bydatelocation = case_when(
        is.na(intensity_bydatelocation) ~ 0,
        TRUE                    ~ intensity_bydatelocation
        ),
      # compute decaying sum of intensity over time
      decay_intensity_bydate = intensity_bydate +
        (AR^0) * MA * lag(intensity_bydate, default=0) +
        (AR^1) * MA * lag(intensity_bydate, 2, default=0) +
        (AR^2) * MA * lag(intensity_bydate, 3, default=0) +
        (AR^3) * MA * lag(intensity_bydate, 4, default=0) +
        (AR^4) * MA * lag(intensity_bydate, 5, default=0) +
        (AR^5) * MA * lag(intensity_bydate, 6, default=0) +
        (AR^6) * MA * lag(intensity_bydate, 7, default=0),
      decay_intensity_bydatelocation = intensity_bydatelocation +
        (AR^0) * MA * lag(intensity_bydatelocation, default=0) +
        (AR^1) * MA * lag(intensity_bydatelocation, 2, default=0) +
        (AR^2) * MA * lag(intensity_bydatelocation, 3, default=0) +
        (AR^3) * MA * lag(intensity_bydatelocation, 4, default=0) +
        (AR^4) * MA * lag(intensity_bydatelocation, 5, default=0) +
        (AR^5) * MA * lag(intensity_bydatelocation, 6, default=0) +
        (AR^6) * MA * lag(intensity_bydatelocation, 7, default=0)
      )

  return(data)
}

plot.time.chart <- function(data = data, location = F) {
  # plots chart of decaying exercise intensity over time

  if (location == TRUE) {
    plot <- ggplot(data, aes(x=date, y=decay_intensity_bydatelocation)) +
      geom_line(stat="smooth", method = "lm", se=FALSE, aes(group=month_number), colour="#7570b3", size=1.2, alpha=0.3) +
      geom_line(size=1.2, colour="#7570b3")
  } else {
    plot <- ggplot(data, aes(x=date, y=decay_intensity_bydate)) +
      geom_line(stat="smooth", method = "lm", se=FALSE, colour="#1b9e77", size=1.2, alpha=0.4) +
      geom_line(size=1.2, colour="#7570b3")
  }

  plot <- plot +
    theme_minimal() +
    ylim(0, NA)

  return(plot)
}
