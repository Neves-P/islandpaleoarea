#' Plot archipelago area and parameter estimates through time
#'
#' @inheritParams default_params_doc
#'
#' @return A faceted ggplot with the areas and parameters estimates through time
#' @export
plot_res_area <- function(ordered_results) {
  estimate_plots <- plot_line_estimates(ordered_results)
  area_plot <- plot_area_time(ordered_results)
  out <- area_plot / estimate_plots + patchwork::plot_layout(guides = "collect")
  out
}
