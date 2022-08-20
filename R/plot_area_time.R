#' Plot total archipelago area through time
#'
#' @param ordered_results
#'
#' @return A ggplot2 line plot with the sum of every archipelago area at all
#' time points
#' @export
#' @author Pedro Santos Neves
plot_area_time <- function(ordered_results) {
  area_plot <- ggplot2::ggplot(ordered_results) +
    ggplot2::geom_line(ggplot2::aes(age, total_area)) +
    ggplot2::ylab("Total archipelago area km^2")+
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.title.x = ggplot2::element_blank())
  area_plot
}