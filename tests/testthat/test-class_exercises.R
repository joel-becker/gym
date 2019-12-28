# TODO: test download data function

context("Testing data integrity")

input_exercises <- exercise_data[, "exercise"]
missing_exercises <- input_exercises[!(input_exercises %in% exercise_classes)]

test_that("No exercises in data not contained in exercise_classes", {
  expect_equal(length(missing_exercises), 0)
})
