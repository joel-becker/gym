#' @title Plot time chart
#'
#' @description Plots chart of decaying exercise intensity over time
#' @param data Data from wrangle_time_chart()
#' @param location Splitting groups by location, FALSE by default
#' @keywords plot
#' @export
#' @examples
#' plot_time_chart()
plot_time_chart <- function(data, location = F) {
  if (location == TRUE) {
    plot <- ggplot2::ggplot(data, aes(x=date, y=decay_intensity_bydatelocation)) +
      ggplot2::geom_line(stat="smooth", method = "lm", se=FALSE, aes(group=month_number), colour="#7570b3", size=1.2, alpha=0.3) +
      ggplot2::geom_line(size=1.2, colour="#7570b3")
  } else {
    plot <- ggplot2::ggplot(data, aes(x=date, y=decay_intensity_bydate)) +
      ggplot2::geom_line(stat="smooth", method = "lm", se=FALSE, colour="#1b9e77", size=1.2, alpha=0.4) +
      ggplot2::geom_line(size=1.2, colour="#7570b3")
  }
  
  plot <- plot +
    ggplot2::theme_minimal() +
    ggplot2::ylim(0, NA)
  
  return(plot)
}


#' @title Plot workout chart
#'
#' @description Plot chart of per-workout intensity over time
#' @param data Data from wrangle_workout_chart()
#' @param location Splitting groups by location, FALSE by default
#' @keywords plot
#' @export
#' @examples
#' plot_workout_chart()
plot_workout_chart <- function(data, location = F) {
  if (location == TRUE) {
    
    plot <- ggplot2::ggplot(data, aes(x=date, y=index_intensity_bydatelocation, group=location, colour=location)) +
      ggplot2::geom_line(aes(y=cummax_index_intensity_bydatelocation), size=1.5) +
      ggplot2::scale_color_manual(values=c("#7570b3", "#1b9e77"))
    
  } else {
    
    plot <- ggplot2::ggplot(data, aes(x=date, y=index_intensity_bydate)) +
      ggplot2::geom_line(aes(y=cummax_index_intensity_bydate), size=1.5) +
      ggplot2::scale_color_manual(values=c("#1b9e77"))
    
  }
  
  plot <- plot +
    ggplot2::geom_point(size=3, alpha=1/3) +
    ggplot2::geom_line(stat="smooth",method = "lm", se=FALSE, size=1.5, alpha=1/3) +
    ggplot2::ylim(0, NA) +
    ggplot2::theme_minimal()
  
  return(plot)
}