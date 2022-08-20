#' Calculate BIC
#'
#' @param loglik Numeric vector with loglikelihood values
#' @param df Numeric vector with degrees of freedom (number of parameters)
#' @param n Numeric with sample size
#'
#' @return Numeric vector with BIC values
#' @export
#'
#' @examples
#' bic <- calc_bic(c(-40, -35), c(2, 1), 100)
calc_bic <- function(loglik, df, n){
  bic <- -2 * loglik + df * (log(n) + log(2 * pi))
  return(bic)
}

