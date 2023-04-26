#' Calculate base rates per archipelago and model
#'
#' @param archipelago_data
#' @param pars
#' @param model
#' @param M
#'
#' @return
#' @export
#'
#' @examples
get_base_rates <- function(archipelago_data, M, pars_res_df, area, distance, model) {

  # General for all models

  lamc_0 <- pars_res_df$lambda_c0
  y <- pars_res_df$y
  mu_0 <- pars_res_df$mu_0
  x <- pars_res_df$x
  K_0 <- pars_res_df$K_0
  z <- pars_res_df$z
  gam_0timesM <- pars_res_df$gamma_0
  alpha <- pars_res_df$alpha
  lama_0 <- pars_res_df$lambda_a0
  beta <- pars_res_df$beta
  d0 <- pars_res_df$d0
  age <- archipelago_data$island_age

  # M16 & M19
  if (isTRUE(model %in% c(16, 19))) {
    lambda_c <- lamc_0 * area^(y + d0 * log(distance))
  }

  # M17
  if (isTRUE(identical(model, 17L))) {
    lambda_c <- lamc_0 * area^(y + 1/(1 + d0 / distance))
  }

  # M18
  if (isTRUE(identical(model, 18L))) {
    lambda_c <- lamc_0 * area^(y + 1/(1 + d0 / distance))
  }

  mu <- mu_0 * area^-x
  K <- K_0 * area^z
  gamma <- (gam_0timesM * distance^-alpha) / M
  lambda_a <- lama_0 * distance^beta
  return(data.frame(
    model = model,
    age = age,
    lambda_c0 = lambda_c,
    mu_0 = mu,
    K = K,
    gamma_0 = gamma,
    lambda_a0 = lambda_a,
    area = area,
    x,
    y,
    z,
    d0,
    beta,
    alpha
  ))
}
