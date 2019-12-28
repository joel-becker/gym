#----------------------------------------------------------------------------------#
# Classes exercises by muscle group
# Author: Joel Becker

# Notes:
#
#----------------------------------------------------------------------------------#


########################################################
######################## Set-up ########################
########################################################

# load libraries
packages <- c("dplyr", "data.table")
new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(packages, library, character.only = TRUE)


########################################################
################### List push groups ###################
########################################################

chest <- c(
  "Bench press",
  "Incline bench press",
  "Decline bench press",
  
  "Supported bench press",
  "Supported incline bench press",
  "Supported decline bench press",
  "Vectra bench press",
  "Vectra incline bench press",
  "Vectra decline bench press",
  "Press-ups",
  "Incline press-ups",
  "Decline press-ups",
  
  "Push chest",
  "Dumbbell chest press",
  "Flys",
  "Upper cable fly",
  "Lower cable fly",
  "Sitting upper cable fly"
)

frontdelt <- c(
  "Bench press",
  "Incline bench press",
  "Decline bench press",
  "Shoulder press",
  "Sitting dumbbell press",
  
  "Supported bench press",
  "Supported incline bench press",
  "Supported decline bench press",
  "Vectra bench press",
  "Vectra incline bench press",
  "Vectra decline bench press",
  "Press-ups",
  "Incline press-ups",
  "Decline press-ups",
  "Supported shoulder press",
  
  "Push shoulders",
  "Standing dumbbell press"
)

sidedelt <- c(
  "Shoulder press",
  "Sitting dumbbell press",
  "Standing dumbbell press",
  
  "Supported shoulder press",
  
  "Lateral raise",
  "Sitting lateral raise",
  "Lateral bench machine",
  "Delt fly",
  "Nutmeg delt fly"
)

tricep <- c(
  "Bench press",
  "Incline bench press",
  "Decline bench press",
  "Shoulder press",
  
  "Supported bench press",
  "Supported incline bench press",
  "Supported decline bench press",
  "Vectra bench press",
  "Vectra incline bench press",
  "Vectra decline bench press",
  "Press-ups",
  "Incline press-ups",
  "Decline press-ups",
  "Supported shoulder press",
  
  "Tricep machine",
  "Tricep pushdown",
  "Two-rope tricep pushdown",
  "Tricep overhead cable",
  "Supported tricep dips"
)

push <- c(chest, frontdelt, sidedelt, tricep)


########################################################
################### List pull groups ###################
########################################################


upperback <- c(
  "Deadlift",
  "Supported deadlift",
  "Hexagon deadlift",
  "Bent over row",
  "Supported row",
  "Inner pullup",
  "Wide pullup",
  
  "Wide row",
  "High Wide row",
  "Longpull inner",
  "Longpull wide",
  "T-bar inner",
  "T-bar wide",
  
  "Shoulder press",
  "Supported shoulder press",
  "Sitting dumbbell press",
  "Standing dumbbell press",
  
  "Inner lat pulldown",
  "Wide lat pulldown",
  "Alternating lat pulldown",
  
  "Rear delt fly",
  "Face pull"
)

midback <- c(
  "Deadlift",
  "Supported deadlift",
  "Hexagon",
  "Bent over row",
  "Supported row",
  "Inner pullup",
  "Wide pullup",
  
  "Wide row",
  "High Wide row",
  "Longpull inner",
  "Longpull wide",
  "T-bar inner",
  "T-bar wide",
  
  "Inner lat pulldown",
  "Wide lat pulldown",
  "Alternating lat pulldown",
  "Upper cable row",
  "Lower cable row",
  "Lawn mower",
  
  "Rear delt fly",
  "Face pull"
)

lowerback <- c(
  "Deadlift",
  "Supported deadlift",
  "Hexagon deadlift"
)

lat <- c(
  "Bent over row",
  "Supported row",
  "Inner pullup",
  "Wide pullup",
  
  "Wide row",
  "High Wide row",
  "Longpull inner",
  "Longpull wide",
  "T-bar inner",
  "T-bar wide",
  
  "Inner lat pulldown",
  "Wide lat pulldown",
  "Alternating lat pulldown",
  "Upper cable row",
  "Lower cable row",
  "Lawn mower"
)

bicep <- c(
  "Bent over row",
  "Supported row",
  "Inner pullup",
  "Wide pullup",
  
  "Wide row",
  "High Wide row",
  "Longpull inner",
  "Longpull wide",
  "T-bar inner",
  "T-bar wide",
  
  "Inner lat pulldown",
  "Wide lat pulldown",
  "Alternating lat pulldown",
  "Upper cable row",
  "Lower cable row",
  "Lawn mower",
  
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
  "Bicep pushdown"
)

reardelt <- c(
  "Bent over row",
  "Supported row",
  "Inner pullup",
  "Wide pullup",
  
  "Wide row",
  "High Wide row",
  "Longpull inner",
  "Longpull wide",
  "T-bar inner",
  "T-bar wide",
  
  "Inner lat pulldown",
  "Wide lat pulldown",
  "Alternating lat pulldown",
  "Upper cable row",
  "Lower cable row",
  "Lawn mower",
  
  "Rear delt fly",
  "Face pull"
)

pull <- c(upperback, midback, lowerback, lat, bicep, reardelt)


########################################################
################### List legs groups ###################
########################################################

quad <- c(
  "Deadlift",
  "Supported deadlift",
  "Hexagon deadlift",
  "Hexagon squat",
  "Squat",
  "Super squat",
  "Supported squat",
  
  "Leg press",
  "Leg extension",
  
  "Kneeling leg curl",
  "Glute",
  
  "Standing calf",
  "Sitting calf",
  "Toe raise"
)

hamstring <- c(
  "Deadlift",
  "Supported deadlift",
  "Hexagon squat",
  "Hexagon deadlift",
  "Squat",
  "Super squat",
  "Supported squat",
  
  "Leg press",
  "Leg extension",
  
  "Kneeling leg curl",
  "Glute",
  
  "Standing calf",
  "Sitting calf",
  "Toe raise"
)

calf <- c(
  "Deadlift",
  "Supported deadlift",
  "Hexagon deadlift",
  "Hexagon squat",
  "Squat",
  "Super squat",
  "Supported squat",
  
  "Leg press",
  "Leg extension",
  "Standing calf",
  "Sitting calf",
  "Toe raise"
)

legs <- c(quad, hamstring, calf)


########################################################
################## List core exercises #################
########################################################

core <- c(
  "Plank",
  "Side plank",
  "Side step",
  "Mix pot",
  
  "Deadlift",
  "Supported deadlift",
  "Hexagon deadlift"
)


########################################################
################ List aerobic exercises ################
########################################################

aerobic <- c(
  "Football",
  "Futsal",
  "Hike"
)


########################################################
################ Aggregate muscle groups ###############
########################################################

all_exercises <- c(push, pull, legs, core, aerobic)

exercise_name <- unique(all_exercises)

exercise_classes <- data.frame(exercise_name=exercise_name) %>%
  mutate(
    chest     = case_when(exercise_name %in% chest ~ 1,     TRUE ~ 0),
    frontdelt = case_when(exercise_name %in% frontdelt ~ 1, TRUE ~ 0),
    sidedelt  = case_when(exercise_name %in% sidedelt ~ 1,  TRUE ~ 0),
    tricep    = case_when(exercise_name %in% tricep ~ 1,    TRUE ~ 0),
    
    upperback = case_when(exercise_name %in% upperback ~ 1, TRUE ~ 0),
    midback   = case_when(exercise_name %in% midback ~ 1,   TRUE ~ 0),
    lowerback = case_when(exercise_name %in% lowerback ~ 1, TRUE ~ 0),
    lat       = case_when(exercise_name %in% lat ~ 1,       TRUE ~ 0),
    bicep     = case_when(exercise_name %in% bicep ~ 1,     TRUE ~ 0),
    reardelt  = case_when(exercise_name %in% reardelt ~ 1,  TRUE ~ 0),
    
    quad      = case_when(exercise_name %in% quad ~ 1,      TRUE ~ 0),
    hamstring = case_when(exercise_name %in% hamstring ~ 1, TRUE ~ 0),
    calf      = case_when(exercise_name %in% calf ~ 1,      TRUE ~ 0),
    
    push      = chest + frontdelt + sidedelt + tricep,
    pull      = upperback + midback + lowerback + lat + bicep + reardelt,
    legs      = quad + hamstring + calf,
    
    total     = push + pull + legs
  )


########################################################
################ Aggregate muscle groups ###############
########################################################

output_path <- paste0(getwd(), "/exercise_classes.txt")
fwrite(exercise_classes, output_path, sep=",")
