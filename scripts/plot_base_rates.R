
galapagos <- archipelagos41_paleo$`0`$Galapagos[[1]]
model_number <- 19
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
  d0 = model_res$d_0
)


area <- c()
distance <- c()
for (time_slice in pars_res_df$age) {

  area <- c(area, archipelagos41_paleo[[time_slice]][["Galapagos"]][[1]]$area)
  distance <- c(distance, archipelagos41_paleo[[time_slice]][["Galapagos"]][[1]]$distance_continent)
}

base_rates <- get_base_rates(
  archipelago_data = galapagos,
  M = 1000,
  pars_res_df = pars_res_df,
  model = model_number,
  area = area,
  distance = distance
)

plot_line_estimates(base_rates)

