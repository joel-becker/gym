#----------------------------------------------------------------------------------#
# Plotting functions for gym data
# Author: Joel Becker

# Notes:
#   
#----------------------------------------------------------------------------------#


########################################################
######################## Set-up ########################
########################################################

# load libraries
packages <- c("ggplot2")
new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(packages, library, character.only = TRUE)


########################################################
##################### Wrangle data #####################
########################################################

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

plot.workout.chart <- function(data = data, location = F) {

  # plot chart of per-workout intensity over time

  if (location == TRUE) {

    plot <- ggplot(data, aes(x=date, y=index_intensity_bydatelocation, group=location, colour=location)) +
      geom_line(aes(y=cummax_index_intensity_bydatelocation), size=1.5) +
      scale_color_manual(values=c("#7570b3", "#1b9e77"))

  } else {

    plot <- ggplot(data, aes(x=date, y=index_intensity_bydate)) +
      geom_line(aes(y=cummax_index_intensity_bydate), size=1.5) +
      scale_color_manual(values=c("#1b9e77"))

  }

  plot <- plot +
    geom_point(size=3, alpha=1/3) +
    geom_line(stat="smooth",method = "lm", se=FALSE, size=1.5, alpha=1/3) +
    ylim(0, NA) +
    theme_minimal()

  return(plot)

}
