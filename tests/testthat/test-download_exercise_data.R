context("Testing data integrity")


data <- gym::download_exercise_data(file_name = "data/exercise_data", file_format = "csv")


# consistent column names
column_names <- c("date", "exercise", "weight", "sets")

test_that("Columns have correct names", {
  expect_named(data, column_names)
})

# TODO: no missing data
# TODO: more general tests (these are too specific to my own data)


# no missing exercises (again probably too specific to)
input_exercises <- exercise_data[, "exercise"]
missing_exercises <- input_exercises[!(input_exercises %in% exercise_classes)]

test_that("No exercises in data not contained in exercise_classes", {
  expect_equal(length(missing_exercises), 0)
})