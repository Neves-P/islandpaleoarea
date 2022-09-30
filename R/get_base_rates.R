#' Calculate base rates per archipelago and model
#'
#' @param archipelago_data
#' @param pars
#' @param model
#'
#' @return
#' @export
#'
#' @examples
get_base_rates <- function(archipelago_data, pars, model) {

  # General for all models
  Archipelago <- archipelago_data$Archipelago
  Area <- archipelago_data$Area
  Distance <- archipelago_data$Distance
  Age <- archipelago_data$Age

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
    lambda_c <- lamc_0 * Area^(y + d0 * log(Distance))
  }

  # M17
  if (isTRUE(identical(model, 17))) {
    d0 <- pars[11]
    lambda_c <- lamc_0 * Area^(y + 1/(1 + d0 / Distance))
  }

  # M18
  if (isTRUE(identical(model, 18))) {
    d0 <- pars[11]
    lambda_c <- lamc_0 * Area^(y + 1/(1 + d0 / Distance))
  }

  mu <- mu_0 * Area^ -x
  K <- K_0 * Area^z
  gamma <- (gam_0timesM * Distance^-alpha) / M
  lamda_a <- lama_0 * Distance^beta
}
