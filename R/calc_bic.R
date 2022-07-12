#' Calculate BIC
#'
#' @param loglik
#' @param k
#' @param n
#'
#' @return
#' @export
#'
#' @examples
calc_bic <- function(loglik, k, n){
  bic <- -2 * loglik + k * (log(n) + log(2 * pi))
  return(bic)
}
