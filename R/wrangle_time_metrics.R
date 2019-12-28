wrangle.time.metrics <- function(data = data) {
  # format dates and set up date-location metrics for intensity comparisons over time

  data <- data %>%

    dplyr::mutate(
      # format dates
      date = as.Date(date, "%m/%d/%Y"),

      # create gym/not-gym indicator
      location = case_when(
        exercise %in% aerobic ~ "aerobic",
        TRUE                  ~ "gym"
      )
    ) %>%

    # intensity by date
    dplyr::group_by(date) %>%
    dplyr::mutate(n_exercise_bydate = n(),
           intensity_bydate  = sum(weight_intensity) / (n_exercise_bydate^exercise_exponent)) %>%
    dplyr::ungroup() %>%

    # intensity by date and location
    dplyr::group_by(date, location) %>%
    dplyr::mutate(
      n_exercise_bydatelocation = n(),
      intensity_bydatelocation  = sum(weight_intensity) / (n_exercise_bydatelocation^exercise_exponent)
    ) %>%
    dplyr::ungroup() %>%

    # index intensity-time metrics to first instance of exercise
    dplyr::group_by(location) %>%
    dplyr::mutate(
      index_intensity_bydate         = intensity_bydate         / first(intensity_bydate),
      index_intensity_bydatelocation = intensity_bydatelocation / first(intensity_bydatelocation)
    ) %>%
    dplyr::arrange(date) %>%
    dplyr::mutate(
      cummax_index_intensity_bydate         = cummax(index_intensity_bydate),
      cummax_index_intensity_bydatelocation = cummax(index_intensity_bydatelocation)
    ) %>%
    dplyr::ungroup()

  return(data)
}
