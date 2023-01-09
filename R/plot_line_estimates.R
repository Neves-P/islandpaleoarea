#' Title
#'
#' @param ordered_results
#'
#' @return
#' @export
#'
#' @examples
plot_line_estimates <- function(ordered_results) {

  lambda_c0_ylim <- max(ordered_results$lambda_c0)
  mu_0_ylim <- max(ordered_results$mu_0)
  gamma_0_ylim <- max(ordered_results$gamma_0)
  lambda_a0_ylim <- max(ordered_results$lambda_a0)
  left_ylim <- max(lambda_c0_ylim, mu_0_ylim, lambda_a0_ylim)
  right_ylim <- gamma_0_ylim

  param_plot <- ggplot2::ggplot(ordered_results) +
    ggplot2::geom_line(ggplot2::aes(age, lambda_c0, colour = "\U03BB\U1D9C")) +
    ggplot2::geom_line(ggplot2::aes(age, mu_0, colour = "\U03BC")) +
    ggplot2::geom_line(ggplot2::aes(age, lambda_a0, colour = "\U03BB\U1D43")) +
    ggplot2::geom_line(ggplot2::aes(age, gamma_0 * 15, colour = "\U03B3")) +
    ggplot2::scale_y_continuous(
      name = "Estimated \U03BB\U1D9C; \U03BC; \U03BB\U1D43",
      sec.axis = ggplot2::sec_axis(~./15, name = "Estimated \U03B3"),
      trans = "log10"
    ) +
    ggplot2::theme_classic() +
    ggplot2::xlab("Time before present") +
    ggplot2::labs(colour = "Parameter")
  param_plot
}
