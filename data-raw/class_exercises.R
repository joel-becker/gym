# list push groups

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
  
  "Chest press",
  "Dumbbell chest press",
  "Flys",
  "Decline cable fly",
  "Incline cable fly",
  "Sitting incline cable fly",
  "Single-arm fly"
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
  "Standing dumbbell press",
  "Front delt machine"
)

sidedelt <- c(
  "Shoulder press",
  "Sitting dumbbell press",
  "Standing dumbbell press",
  
  "Supported shoulder press",
  
  "Lateral raise",
  "Sitting lateral raise",
  "Lateral raise machine",
  "Delt fly",
  "Nutmeg delt cable"
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
  "Supported tricep dip",
  "Skullcrusher"
)

push <- c(chest, frontdelt, sidedelt, tricep)


# list pull groups

upperback <- c(
  "Deadlift",
  "Supported deadlift",
  "Hexagon deadlift",
  "Barbell row",
  "Supported row",
  "Inner pullup",
  "Wide pullup",
  
  "Wide row",
  "High wide row",
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
  "Barbell row",
  "Supported row",
  "Inner pullup",
  "Wide pullup",
  
  "Wide row",
  "High wide row",
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
  "Barbell row",
  "Supported row",
  "Inner pullup",
  "Wide pullup",
  
  "High wide row",
  "Longpull wide",
  "T-bar wide",
  
  "Inner lat pulldown",
  "Wide lat pulldown",
  "Alternating lat pulldown",
  "Upper cable row",
  "Lawn mower"
)

bicep <- c(
  "Barbell row",
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
  "Barbell row",
  "Supported row",
  "Inner pullup",
  "Wide pullup",
  
  "Wide row",
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


# list legs groups

quad <- c(
  "Hexagon squat",
  "Squat",
  "Hack squat",
  "Supported squat",
  
  "Leg press",
  "Leg extension"
)

hamstring <- c(
  "Deadlift",
  "Supported deadlift",
  "Hexagon deadlift",
  "Rack deadlift",
  
  "Hamstring curl"
)

calf <- c(
  "Hexagon squat",
  "Squat",
  
  "Deadlift",
  "Hexagon deadlift",
  
  "Standing calf",
  "Sitting calf",
  "Toe raise"
)

hip <- c(
  "Hexagon squat",
  "Squat",
  
  "Deadlift",
  "Hexagon deadlift",
  
  "Hip adduction",
  "Hip abduction"
)

legs <- c(quad, hamstring, calf, hip)


# list core exercises

core <- c(
  "Plank",
  "Side plank",
  "Side step",
  "Mix pot",
  
  "Deadlift",
  "Hexagon deadlift",
  
  "Squat",
  "Hexagon squat",
  
  "Overhead press",
  
  "Ab crunch machine"
)


# list aerobic exercises

aerobic <- c(
  "Football",
  "Futsal",
  "Hike"
)


# aggregate muscle groups
all_exercises <- c(push, pull, legs, core, aerobic)
exercise_name <- unique(all_exercises)
anaerobic <- exercise_name[!(exercise_name %in% aerobic)]


# make lists into data frames for saving
aerobic <- data.frame(aerobic)
anaerobic <- data.frame(anaerobic)


# class exercises

exercise_classes <- data.frame(exercise_name=exercise_name) %>%
  dplyr::mutate(
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

# output data

classes_output_path <- paste0(getwd(), "/data/exercise_classes.txt")
aerobic_output_path <- paste0(getwd(), "/data/aerobic_classes.txt")
anaerobic_output_path <- paste0(getwd(), "/data/anaerobic_classes.txt")

use_data(exercise_classes, overwrite = TRUE)
use_data(aerobic, overwrite = TRUE)
use_data(anaerobic, overwrite = TRUE)

