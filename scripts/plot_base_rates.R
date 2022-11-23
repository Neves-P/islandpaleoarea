
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


plots <- list()
for(i in 1:41) {
  plots[[i]] <- ggplot2::ggplot(base_rates[[i]]) +
    ggplot2::geom_line(ggplot2::aes(age, lambda_c0, colour = "\U03BB\U1D9C")) +
    ggplot2::ggtitle(names(base_rates[i]))
}
names(base_rates)


# Combine single arch plots with area curve
# Plot also the hyperparameters per model
# If applicable, choose then one model to look across
# If hyperparameters are stable, then area is driving the change
# Area and base parameters through time in plot. Will have to rescale. Main point is: do parameters follow area?




# Choose 1 model for which
# 1 Plot with Hyperpars as function of age
# 41 Plot with archipelago rates and areas as function of age
# Combine in 6x7

