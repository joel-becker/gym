# TODO: test download data function

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
