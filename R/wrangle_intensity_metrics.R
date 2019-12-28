wrangle.intensity.metrics <- function(data = data) {
  # compute intensity metrics (for within- and between-exercise comparisons)

  data <- data %>%

    # create arbitrary intensity measure
    mutate(intensity = weight * (sets^sets_exponent)) %>%

    # intensity wrangling by exercise
    group_by(exercise) %>%
    mutate(
      # mean intensity of each exercise
      mean_intensity = mean(intensity),
      # index intensity to first exercise for each exercise
      index_intensity = intensity / first(intensity)
    ) %>%
    ungroup() %>%

    # intensity wrangling by exercise type
    mutate(
      # normalise intensity
      normalise_intensity = intensity / mean_intensity,
      # weight intensity measure by exercise type
      weight_intensity = case_when(
        exercise %in% aerobic         ~ normalise_intensity * aerobic_intensity,
        exercise %in% compound        ~ normalise_intensity * compound_intensity,
        exercise %in% almost_compound ~ normalise_intensity * almost_compound_intensity,
        TRUE                          ~ normalise_intensity
      )
    )

  return(data)
}
