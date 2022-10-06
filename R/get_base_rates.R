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
get_base_rates <- function(archipelago_data, M, pars, model) {

  # General for all models
  area <- archipelago_data[[1]]$area
  distance <- archipelago_data[[1]]$distance_continent

  lamc_0 <- pars[1]
  y <- pars[2]
  mu_0 <- pars[3]
  x <- pars[4]
  K_0 <- pars[5]
  z <- pars[6]
  gam_0timesM <- pars[7]
  alpha <- pars[8]
  lama_0 <- pars[9]
  beta <- pars[10]

  # M16 & M19
  if (isTRUE(model %in% c(16, 19))) {
    d0 <- pars[11]
    lambda_c <- lamc_0 * area^(y + d0 * log(distance))
  }

  # M17
  if (isTRUE(identical(model, 17))) {
    d0 <- pars[11]
    lambda_c <- lamc_0 * area^(y + 1/(1 + d0 / distance))
  }

  # M18
  if (isTRUE(identical(model, 18))) {
    d0 <- pars[11]
    lambda_c <- lamc_0 * area^(y + 1/(1 + d0 / distance))
  }

  mu <- mu_0 * area^ -x
  K <- K_0 * area^z
  gamma <- (gam_0timesM * distance^-alpha) / M
  lambda_a <- lama_0 * distance^beta
  return(data.frame(model = model, lambda_c = lambda_c, mu = mu, K = K, gamma = gamma, lambda_a = lambda_a))
}
