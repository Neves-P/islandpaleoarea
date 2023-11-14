#' Rates and area archipelago faceted
#'
#' @param base_rates
#'
#' @return A ggplot with each estimated rate profile and area per archipelago
#' in a facet
#' @export
#'
facet_archipelagos <- function(base_rates,
                               standardisation = FALSE,
                               transformation = FALSE,
                               log_gamma = FALSE) {


  rates_plots <- list()
  combined_plots <- list()
  area_plots <- list()
  # ylim_max_global <- max(unlist(lapply(base_rates, `[[`, 8)))
  # ylim_max_global <- ifelse(transformation == TRUE, log10(ylim_max_global), ylim_max_global)
  for (i in seq_along(base_rates)) {

    rates_plots[[i]] <-
      plot_line_estimates(
        ordered_results = base_rates[[i]],
        standardisation = standardisation,
        log_gamma = log_gamma
      )
    if(isTRUE(transformation)) {
      base_rates[[i]]$area <- log10(base_rates[[i]]$area)
    }
    # ylim_max <- max(base_rates[[i]]$area)
    area_plots[[i]] <- ggplot2::ggplot(base_rates[[i]]) +
      ggplot2::geom_line(ggplot2::aes(age, area)) +
      ggplot2::theme_classic() +
      ggplot2::ggtitle(gsub(pattern = "_", replacement = " ", x = names(base_rates[i]))) +
      ggplot2::coord_cartesian(ylim = c(0, NA)) +
      ggplot2::theme(
        legend.title = ggplot2::element_blank(),
        axis.title = ggplot2::element_blank(),
        axis.text.y.left = ggplot2::element_text(size = 6),
        axis.text.x = ggplot2::element_text(size = 6),
        title = ggplot2::element_text(size = 6)
      )

    rates_plots[[i]] <- rates_plots[[i]] +
      ggplot2::theme_classic() +
      ggplot2::theme(legend.title = ggplot2::element_blank(),
                     axis.title = ggplot2::element_blank(),
                     axis.text.y.left = ggplot2::element_text(size = 6),
                     axis.text.x = ggplot2::element_text(size = 6)
      )
    ggplot2::xlab("Time before present")

    combined_plots[[i]] <- patchwork::wrap_plots(area_plots[[i]], rates_plots[[i]]) &
    ggplot2::scale_fill_continuous(guide = ggplot2::guide_legend()) &
      ggplot2::theme(legend.position = "bottom")
  }

  out1 <- patchwork::wrap_plots(combined_plots[1:10],
                                guides = "collect",
                                ncol = 2,
                                nrow = 5) &
    ggplot2::theme(legend.position = "bottom")
  out2 <-
    patchwork::wrap_plots(
      combined_plots[11:20],
      guides = "collect",
      ncol = 2,
      nrow = 5,
      tag_level = "new"
    )  &
    ggplot2::theme(legend.position = "bottom")
  out3 <- patchwork::wrap_plots(combined_plots[21:30],
                                guides = "collect",
                                ncol = 2,
                                nrow = 5) &
    ggplot2::theme(legend.position = "bottom")
  out4 <-
    patchwork::wrap_plots(
      combined_plots[31:41],
      guides = "collect",
      ncol = 3,
      nrow = 4,
      tag_level = "new"
    )  &
    ggplot2::theme(legend.position = "bottom")
  list(out1, out2, out3, out4)
}
