#' @title Test download data
#'
#' @description Tests integrity of downloaded data, as is necessary for reasonable visualisations.
#' @param data Data
#' @keywords download
#' @export
#' @examples
#' test_downloaded_data()
test_downloaded_data <- function(data, exercise_data){
  # no exercises in data not contained in exercise_classes.txt
  ##exercise_data <- gym::download_exercise_data(file_name = "data/exercise_data", file_format = "csv")
  
  input_exercises <- exercise_data[, "exercise"]
  missing_exercises <- input_exercises[!(input_exercises %in% exercise_classes)]
  
  if (length(missing_exercises) > 0) {
    for (exercise in missing_exercises) {
      print(paste0("Missing exercise: ", exercise))
    }
    stop("above exercises in your data are not contained in exercises_classes.txt!")
  }
  
  # no missing data
  missing_date <- sum(is.na(exercise[["date"]]))
  missing_exercise <- sum(is.na(exercise[["exercise"]]))
  missing_weight <- sum(is.na(exercise[["weight"]]))
  missing_sets <- sum(is.na(exercise[["sets"]]))
  missing_total <- missing_date + missing_exercise + missing_weight + missing_sets
  
  if (missing_total > 0) {
    print(paste0("Missing dates: ", missing_date))
    print(paste0("Missing exercises: ", missing_exercise))
    print(paste0("Missing weights: ", missing_weight))
    print(paste0("Missing sets: ", missing_sets))
    stop("your data contains missing entries!")
  }
}
input_exercises <- exercise_data[, "exercise"]
missing_exercises <- input_exercises[!(input_exercises %in% exercise_classes)]

test_that("No exercises in data not contained in exercise_classes", {
  expect_equal(length(missing_exercises), 0)
})


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

