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

compound <- c(
  # push
  "Bench press",
  "Incline bench press",
  "Decline bench press",
  "Shoulder press",

  # pull
  "Bent over row",

  # legs
  "Squat",
  "Deadlift",
  "Hexagon squat",
  "Hexagon deadlift"
  )

almost_compound <- c(
  # push
  "Supported bench press",
  "Supported incline bench press",
  "Supported decline bench press",
  "Supported shoulder press",
  "Dumbbell chest press",
  "Standing dumbbell press",
  "Sitting dumbbell press",

  # pull
  "Supported deadlift",
  "Supported row",
  "Inner pullup",
  "Wide pullup",

  # legs
  "Super squat",
  "Supported squat")

push_compound <- c(
  "Bench press",
  "Incline bench press",
  "Decline bench press",
  "Shoulder press"
)

push_almost_compound <- c(
  "Supported bench press",
  "Supported incline bench press",
  "Supported decline bench press",
  "Vectra bench press",
  "Vectra incline bench press",
  "Vectra decline bench press",
  "Press-ups",
  "Incline press-ups",
  "Decline press-ups",
  "Supported shoulder press"
)

tricep <- c(
  push_compound,
  push_almost_compound,
  "Tricep machine",
  "Tricep pushdown",
  "Two-rope tricep pushdown",
  "Tricep overhead cable",
  "Supported tricep dips"
)

chest <- c(
  push_compound[-"Shoulder press"],
  push_almost_compound[-"Supported shoulder press"],
  "Push chest",
  "Dumbbell chest press",
  "Flys",
  "Upper cable fly",
  "Lower cable fly",
  "Sitting upper cable fly"
)

frontdelt <- c(
  push_compound,
  push_almost_compound,
  "Push shoulders",
  "Standing dumbbell press",
  "Sitting dumbbell press"
)

sidedelt <- c(
  "Lateral raise",
  "Sitting lateral raise",
  "Lateral bench machine",
  "Delt fly",
  "Nutmeg delt fly"
)

push <- c(
  push_compound,
  push_almost_compound,
  chest,
  frontdelt,
  tricep,
  sidedelt
) ; push <- unique(push)

pull_compound <- c()

pull_almost_compound <- c(
  "Supported row",
  "Inner pullup",
  "Wide pullup"
)

row <- c()

lat <- c()

bicep <- c()

reardelt <- c()

pull <- c(
  # compound movements
  "Deadlift",
  "Supported deadlift",
  "Hexagon",
  "Bent over row",
  "Supported row",
  "Inner pullup",
  "Wide pullup",

  # rows
  "Wide row",
  "High Wide row",
  "Longpull inner",
  "Longpull wide",
  "T-bar inner",
  "T-bar wide",

  # lats
  "Inner lat pulldown",
  "Wide lat pulldown",
  "Alternating lat pulldown",
  "Upper cable row",
  "Lower cable row",
  "Lawn mower",

  # biceps
  "Bicep machine",
  "Bicep curl",
  "Incline bicep curl",
  "Concentration curl",
  "Hammer curl",
  "Side hammer curl",
  "Barbell curl",
  "Reverse barbell curl",
  "Preacher curl",
  "Reverse preacher curl",
  "Backward bicep curl",
  "Bicep pushdown",

  # rear delt
  "Rear delt",
  "Face pull"
  )

legs <- c(
  # compound movements
  "Deadlift",
  "Supported deadlift",
  "Hexagon",
  "Squat",
  "Super squat",
  "Supported squat",

  # quads
  "Leg press",
  "Leg extension",

  # hamstring/glutes
  "Kneeling leg curl",
  "Glute",

  # calves
  "Standing calf",
  "Sitting calf",
  "Toe raise"
  )
