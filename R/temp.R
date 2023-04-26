
model_numbers <- 17:19
for (model_number in model_numbers) {


  model_res <- dplyr::filter(ordered_results_paleo, model == model_number)

  pars_res_df <- data.frame(
    age = model_res$age,
    lambda_c0 = model_res$lambda_c0,
    mu_0 = model_res$mu_0,
    K_0 = model_res$K_0,
    gamma_0 = model_res$gamma_0,
    lambda_a0 = model_res$lambda_a0,
    x = model_res$x,
    y = model_res$y,
    z = model_res$z,
    alpha = model_res$alpha,
    beta = model_res$beta,
    d0 = model_res$d_0,
    loglik = model_res$loglik
  )

  names(archipelagos41_paleo[[1]])
  areas <- list()
  distances <- list()
  for (archipelago in names(archipelagos41_paleo[[1]])) {
    area <- c()
    distance <- c()
    for (time_slice in pars_res_df$age) {
      area <- c(area, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$area)
      distance <- c(distance, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$distance_continent)
    }
    areas[[archipelago]] <- area
    distances[[archipelago]] <- distance
  }
  base_rates <- list()
  for (archipelago in names(archipelagos41_paleo[[1]])) {
    base_rates[[archipelago]] <- get_base_rates(
      archipelago_data = archipelagos41_paleo[[1]][[archipelago]][[1]],
      M = 1000,
      pars_res_df = pars_res_df,
      model = model_number,
      area = areas[[archipelago]],
      distance = distances[[archipelago]]
    )
  }
  for (archipelago in names(archipelagos41_paleo[[1]])) {
    base_rates[[archipelago]]$age <- pars_res_df$age
  }


  # Individual plots
  rates_plots <- list()
  combined_plots <- list()
  area_plots <- list()
  hyperpars_plots <- list()
  for(i in 1:41) {
    rates_plots[[i]] <- plot_line_estimates(base_rates[[i]])

    area_plots[[i]] <- ggplot2::ggplot(base_rates[[i]]) +
      ggplot2::geom_line(ggplot2::aes(age, area)) +
      ggplot2::theme_classic() +
      ggplot2::xlab("Time before present") +
      ggplot2::ylab("Area") +
      ggplot2::theme(legend.title = ggplot2::element_blank(), axis.title = ggplot2::element_blank())

    rates_plots[[i]] <- rates_plots[[i]] +
      # ggplot2::ggplot(base_rates[[i]]) +
      # No need to plot the hyperpars, they are global and not archipelago level
      # ggplot2::geom_line(ggplot2::aes(age, x, colour = "x")) +
      # ggplot2::geom_line(ggplot2::aes(age, d0, colour = "d0")) +
      # ggplot2::geom_line(ggplot2::aes(age, beta, colour = "beta")) +
      # ggplot2::geom_line(ggplot2::aes(age, alpha, colour = "alpha")) +
      ggplot2::theme_classic() +
      ggplot2::theme(legend.title = ggplot2::element_blank(),
                     axis.title = ggplot2::element_blank()
      ) +
      ggplot2::xlab("Time before present")


    combined_plots[[i]] <- (area_plots[[i]] + rates_plots[[i]] +
                              patchwork::plot_annotation(
                                title = paste0(gsub("_", " ", names(base_rates[i]), "_"), " m ", model_number)
                              )) +
      ggplot2::scale_fill_continuous(guide = ggplot2::guide_legend()) +
      ggplot2::theme(legend.position = "bottom")
  }

  out <- patchwork::wrap_plots(combined_plots, guides = "collect", ncol = 6, nrow = 7)  &
    ggplot2::theme(legend.position = "bottom")
  ggplot2::ggsave(paste0("combined_", model_number, ".pdf"), out)
}

