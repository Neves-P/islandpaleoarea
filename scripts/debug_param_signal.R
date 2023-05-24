## Chatham and Ascension

model_number <- 17L

model_res_comparison <- dplyr::filter(ordered_results_paleo, model == model_number)

pars_res_df <- data.frame(
  age = model_res_comparison$age,
  lambda_c0 = model_res_comparison$lambda_c0,
  mu_0 = model_res_comparison$mu_0,
  K_0 = model_res_comparison$K_0,
  gamma_0 = model_res_comparison$gamma_0,
  lambda_a0 = model_res_comparison$lambda_a0,
  x = model_res_comparison$x,
  y = model_res_comparison$y,
  z = model_res_comparison$z,
  alpha = model_res_comparison$alpha,
  beta = model_res_comparison$beta,
  d0 = model_res_comparison$d_0,
  loglik = model_res_comparison$loglik
)
areas <- list()
distances <- list()
archipelago_names <- c("Ascension", "Chatham")
for (archipelago in archipelago_names) {
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
for (archipelago in archipelago_names) {
  base_rates[[archipelago]] <- get_base_rates(
    archipelago_data = archipelagos41_paleo[[1]][[archipelago]][[1]],
    M = 1000,
    pars_res_df = pars_res_df,
    model = model_number,
    area = areas[[archipelago]],
    distance = distances[[archipelago]]
  )
  base_rates[[archipelago]]$age <- pars_res_df$age
}

plot(base_rates[[1]]$mu_0 - base_rates[[1]]$mu_0[1], type = "l")
plot(base_rates[[2]]$mu_0 - base_rates[[2]]$mu_0[1], type = "l")
plot(pars_res_df$mu_0, type = "l")
plot(pars_res_df$x, type = "l")
plot(base_rates[[2]]$mu_0 - base_rates[[2]]$mu_0[1], type = "l")

# Note: Maybe the issue is the baseline is higher in Ascension vs Chatham.
# 1st time point is not representative?
