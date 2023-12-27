#' Title
#'
#' @inheritParams default_params_doc
#'
#' @return A plot with the line
#' @export
plot_line_estimates <- function(ordered_results, standardisation = FALSE, log_gamma) {

  if (identical(standardisation, "ratio")) {
    ordered_results$lambda_c0 <- ordered_results$lambda_c0 / ordered_results$lambda_c0[1]
    ordered_results$mu_0 <- ordered_results$mu_0 / ordered_results$mu_0[1]
    ordered_results$gamma_0 <- ordered_results$gamma_0 / ordered_results$gamma_0[1]
    ordered_results$lambda_a0 <- ordered_results$lambda_a0 / ordered_results$lambda_a0[1]
  } else if (identical(standardisation, "difference")) {
    ordered_results$lambda_c0 <- ordered_results$lambda_c0 - ordered_results$lambda_c0[1]
    ordered_results$mu_0 <- ordered_results$mu_0 - ordered_results$mu_0[1]
    ordered_results$gamma_0 <- ordered_results$gamma_0 - ordered_results$gamma_0[1]
    ordered_results$lambda_a0 <- ordered_results$lambda_a0 - ordered_results$lambda_a0[1]
  }
  if (log_gamma) {
    ordered_results$gamma_0 <- log(ordered_results$gamma_0)
  }
  param_plot <- ggplot2::ggplot(ordered_results) +
    ggplot2::geom_line(ggplot2::aes(age, lambda_c0, colour = "*\U03BB\U1D9C*")) +
    ggplot2::geom_line(ggplot2::aes(age, mu_0, colour = "*\U03BC*")) +
    ggplot2::geom_line(ggplot2::aes(age, lambda_a0, colour = "*\U03BB\U1D43*")) +
    ggplot2::geom_line(ggplot2::aes(age, gamma_0, colour = "*\U03B3*")) +
    ggplot2::theme_classic() +
    ggplot2::theme(legend.title = ggplot2::element_blank(),
                   legend.text = ggtext::element_markdown(),
                   axis.title.y = ggtext::element_markdown()) +
    ggplot2::xlab("Time before present") +
    ggplot2::ylab("Estimated rates") +
    ggplot2::scale_color_brewer(palette = "Set2")

  if (log_gamma) {
    # param_plot <- param_plot + ggplot2::scale_y_continuous(
    #   name = "  Estimated \U03BB\U1D9C; \U03BC; \U03BB\U1D43",
    #   sec.axis = ggplot2::sec_axis(~log(.), name = "Estimated log(\U03B3)", breaks = seq(1, 4, 0.1))
    # )
    param_plot <- param_plot + ggplot2::scale_y_continuous(
      name = "Estimated *\U03BB\U1D9C*; *\U03BC*; *\U03BB\U1D43*; log(*\U03B3*)"
    )
  }
  param_plot
}
