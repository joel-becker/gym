#' @title Test download data
#'
#' @description Tests integrity of downloaded data, as is necessary for reasonable visualisations.
#' @param data Data
#' @keywords test
#' @export
#' @examples
#' test_downloaded_data()
test_downloaded_data <- function(exercise_data, exercise_classes){
  # no exercises in data not contained in exercise_classes.txt
  input_exercises <- exercise_data[, "exercise"]
  missing_exercises <- input_exercises[!(input_exercises %in% exercise_classes)]
  
  if (length(missing_exercises) > 0) {
    for (exercise in missing_exercises) {
      print(paste0("Missing exercise: ", exercise))
    }
    stop("above exercises in your data are not contained in exercises_classes.txt!")
  }
  
  # no missing data
  missing_date <- sum(is.na(exercise_data[["date"]]))
  missing_exercise <- sum(is.na(exercise_data[["exercise"]]))
  missing_weight <- sum(is.na(exercise_data[["weight"]]))
  missing_sets <- sum(is.na(exercise_data[["sets"]]))
  missing_total <- missing_date + missing_exercise + missing_weight + missing_sets
  
  if (missing_total > 0) {
    print(paste0("Missing dates: ", missing_date))
    print(paste0("Missing exercises: ", missing_exercise))
    print(paste0("Missing weights: ", missing_weight))
    print(paste0("Missing sets: ", missing_sets))
    stop("your data contains missing entries!")
  }
}


#' @title Download exercise data
#'
#' @description Downloads and returns data from google drive
#' @param file_name File name
#' @param file_format File format
#' @keywords download
#' @export
#' @examples
#' download_exercise_data()
download_exercise_data <- function(
  file_name = "exercise_data",
  file_format = "csv"
) {
  # downloads and returns data from google drive
  
  googledrive::drive_download(file_name, type = file_format, overwrite = TRUE)
  path <- paste0(file_name, ".", file_format)
  data <- data.table::fread(path)
  
  return(data)
}


#' @title Download and test exercise data
#'
#' @description Download and test exercise data at higher level using previous functions
#' @param data Data
#' @keywords download
#' @export
#' @examples
#' get_data()
get_data <- function(
  file_name,
  file_format,
  exercise_classes = fread("data/exercise_classes.txt")
) {
  exercise_data <- gym::download_exercise_data(file_name = "exercise_data", file_format = "csv")
  
  test_downloaded_data(exercise_data, exercises_classes)
  
  return(data)
}

