download_exercise_data <- function(file_name = "exercise_data", file_format = "csv") {
  # downloads and returns data from google drive

  googledrive::drive_download(file_name, type = file_format, overwrite=TRUE)
  path <- paste0(file_name, ".", file_format)
  data <- data.table::fread(path)

  return(data)
}
