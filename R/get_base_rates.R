#' Calculate base rates per archipelago and model
#'
#' @inheritParams default_params_doc
#'
#' @return A data frame with base rates which depend on the model and archipelago
#' @export
get_base_rates <- function(archipelago_data,
                           M,
                           pars_res_df,
                           area,
                           distance,
                           model) {

  # General for all models
  lambda_c0 <- pars_res_df$lambda_c0
  y <- pars_res_df$y
  mu_0 <- pars_res_df$mu_0
  x <- pars_res_df$x
  K_0 <- pars_res_df$K_0
  z <- pars_res_df$z
  gam_0timesM <- pars_res_df$gamma_0
  alpha <- pars_res_df$alpha
  lama_0 <- pars_res_df$lambda_a0
  beta <- pars_res_df$beta
  d0 <- pars_res_df$d_0
  age <- archipelago_data$island_age
  model <- as.integer(model)
  # M16 & M19
  if (isTRUE(model %in% c(16L, 19L))) {
    lambda_c <- lambda_c0 * area^(y + d0 * log(distance))
  }

  # M17
  if (isTRUE(identical(model, 17L))) {
    lambda_c <- lambda_c0 * area^(y + 1 / (1 + d0 / distance))
  }

  # M18
  if (isTRUE(identical(model, 18L))) {
    lambda_c <- lambda_c0 * area^(y + 1 / (1 + d0 / distance))
  }

  # mu_arch <- mu_0 * area^-x
  mu_0 <- mu_0 * area^-x
  K <- K_0 * area^z
  gamma <- (gam_0timesM * distance^-alpha) / M
  lambda_a <- lama_0 * distance^beta
  return(data.frame(
    model = model,
    age = age,
    lambda_c0 = lambda_c,
    # mu_arch = mu_arch,
    mu_0 = mu_0,
    K = K,
    gamma_0 = gamma,
    lambda_a0 = lambda_a,
    area = area,
    x = x,
    y = y,
    z = z,
    d_0 = d0,
    beta = beta,
    alpha = alpha
  ))
}
