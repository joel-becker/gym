#' @title Wrangle intensity metrics
#'
#' @description Compute intensity metrics (for within- and between-exercise comparisons)
#' @param data Data from download_data()
#' @param sets_exponent Exponent for weighting number of sets
#' @keywords wrangle
#' @export
#' @examples
#' wrangle_intensity_metrics()

wrangle_intensity_metrics <- function(
  data = data,
  sets_exponent = 0.6,
  aerobic_intensity = 2,
  compound_intensity = 1.3,
  almost_compound_intensity = 1.1
  ) {
  # compute intensity metrics (for within- and between-exercise comparisons)

  data <- data %>%

    # create arbitrary intensity measure
    dplyr::mutate(intensity = weight * (sets^sets_exponent)) %>%

    # intensity wrangling by exercise
    dplyr::group_by(exercise) %>%
    dplyr::mutate(
      # mean intensity of each exercise
      mean_intensity = mean(intensity),
      # index intensity to first exercise for each exercise
      index_intensity = intensity / first(intensity)
    ) %>%
    dplyr::ungroup() %>%

    # intensity wrangling by exercise type
    dplyr::mutate(
      # normalise intensity
      normalise_intensity = intensity / mean_intensity,
      # weight intensity measure by exercise type
      weight_intensity = case_when(
        exercise %in% aerobic         ~ normalise_intensity * aerobic_intensity,
        #exercise %in% compound        ~ normalise_intensity * compound_intensity,
        #exercise %in% almost_compound ~ normalise_intensity * almost_compound_intensity,
        TRUE                          ~ normalise_intensity
      )
    )

  return(data)
}


#' @title Wrangle time metrics
#'
#' @description Format dates and set up date-location metrics for intensity comparisons over time
#' @param data Data from download_data()
#' @param exercise_exponent Exponent for weighting number of exercises
#' @keywords wrangle
#' @export
#' @examples
#' wrangle_time_metrics()

wrangle_time_metrics <- function(
  data,
  exercise_exponent = 0.6
) {
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
