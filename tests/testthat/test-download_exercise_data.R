data <- gym::download_exercise_data(file_name = "exercise_data", file_format = "csv")
column_names <- colnames(data)

test_that("Columns have correct names", {
  expect_named(data, column_names)
})
