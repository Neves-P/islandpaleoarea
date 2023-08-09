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
                               transformation = FALSE) {


  rates_plots <- list()
  combined_plots <- list()
  area_plots <- list()
  hyperpars_plots <- list()
  ylim_max_global <- max(unlist(lapply(base_rates, `[[`, 8)))
  ylim_max_global <- ifelse(transformation == TRUE, log10(ylim_max_global), ylim_max_global)
  for(i in 1:41) {

    rates_plots[[i]] <- plot_line_estimates(base_rates[[i]], standardisation)
    if(isTRUE(transformation)) {
      base_rates[[i]]$area <- log10(base_rates[[i]]$area)
    }
    # ylim_max <- max(base_rates[[i]]$area)
    area_plots[[i]] <- ggplot2::ggplot(base_rates[[i]]) +
      ggplot2::geom_line(ggplot2::aes(age, area)) +
      ggplot2::theme_classic() +
      ggplot2::xlab("Time before present") +
      ggplot2::ylab("Area") +
      ggplot2::coord_cartesian(ylim = c(0, ylim_max_global)) +
      # ggplot2::scale_y_log10(breaks = scales::trans_breaks("log10", function(x) 10^x),
      #               labels = scales::trans_format("log10", scales::math_format(10^.x))) +
      # ggplot2::scale_y_continuous(
      #   trans = "log10", labels = scales::math_format(10^.x, format = log10)
      # ) +
      ggplot2::theme(legend.title = ggplot2::element_blank(), axis.title = ggplot2::element_blank()) +
      ggplot2::ggtitle(
        paste0(gsub("_", " ", names(base_rates[i]), "_"), " m ", model)
      )

    rates_plots[[i]] <- rates_plots[[i]] +
      ggplot2::theme_classic() +
      ggplot2::theme(legend.title = ggplot2::element_blank()
                     # axis.title = ggplot2::element_blank()
      ) +
      ggplot2::xlab("Time before present")


    combined_plots[[i]] <- (area_plots[[i]] + rates_plots[[i]]) +
      ggplot2::scale_fill_continuous(guide = ggplot2::guide_legend()) +
      ggplot2::theme(legend.position = "bottom")
  }

  out <- patchwork::wrap_plots(combined_plots, guides = "collect", ncol = 6, nrow = 7)  &
    ggplot2::theme(legend.position = "bottom")
  out
}
