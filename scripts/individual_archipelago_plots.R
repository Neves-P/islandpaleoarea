library(Cairo)

models <- 17:19
for (model in models) {


  model_res <- dplyr::filter(ordered_results_paleo, model == model)

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
      model = model,
      area = areas[[archipelago]],
      distance = distances[[archipelago]]
    )
  }
  for (archipelago in names(archipelagos41_paleo[[1]])) {
    base_rates[[archipelago]]$age <- pars_res_df$age
  }
  out_diff <- facet_archipelagos(base_rates, standardisation = "difference")
  out_ratio <- facet_archipelagos(base_rates, standardisation = "ratio")
  out <- facet_archipelagos(base_rates, standardisation = FALSE)
  ggplot2::ggsave(paste0("figures/combined_diff_", model, ".pdf"), out_diff, width = 30, height = 10, device = cairo_pdf)
  ggplot2::ggsave(paste0("figures/combined_ratio_", model, ".pdf"), out_ratio, width = 30, height = 10, device = cairo_pdf)
  ggplot2::ggsave(paste0("figures/combined_", model, ".pdf"), out, width = 30, height = 10, device = cairo_pdf)



}

