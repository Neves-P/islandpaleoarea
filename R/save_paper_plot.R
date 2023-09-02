#' Save a plot to current directory
#'
#' @inheritParams default_params_doc
#'
#' @return NULL. A pdf and png files with the plot to save are saved to the
#' working directory
#' @export
#' @author Pedro Santos Neves
#'
#' @examples
#' \dontrun{
#' plotting_table <- prepare_results_to_plot(readRDS("full_res.rds"))
#' plot <- plot_estimate_results(
#'   plotting_table,
#'   parameter_name = "lambda_c",
#'   partition_by = "island_age",
#'   colour_by = "stac",
#'   shape_by = "c_m"
#' )
#' save_paper_plot(plot_to_save = plot, "lac_plot", type_size = "full_size")
#' }
save_paper_plot <- function(plot_to_save, file_name, type_size = "full_size") {

  file_name <- tools::file_path_sans_ext(file_name)

  if (identical(type_size, "full_size")) {
    ggplot2::ggsave(
      plot = plot_to_save,
      filename = file.path("figures", paste0(file_name, ".png")),
      device = "png",
      width = 168,
      height = 150,
      units = "mm",
      dpi = 600
    )
    ggplot2::ggsave(
      plot = plot_to_save,
      filename = file.path("figures", paste0(file_name, ".pdf")),
      device = cairo_pdf,
      width = 168,
      height = 150,
      units = "mm",
    )
  } else if (identical(type_size, "half_size")) {
    ggplot2::ggsave(
      plot = plot_to_save,
      filename = file.path("figures", paste0(file_name, ".png")),
      device = cairo_pdf,
      width = 168 / 2,
      height = 150 / 2,
      units = "mm",
      dpi = 600
    )
    ggplot2::ggsave(
      plot = plot_to_save,
      filename = file.path("figures", paste0(file_name, ".pdf")),
      device = cairo_pdf,
      width = 168 / 2,
      height = 150 / 2,
      units = "mm"
    )
  }
}
