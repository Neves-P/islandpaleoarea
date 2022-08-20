#' Calculate BIC weights
#'
#' @param bics
#'
#' @return A vector with BIC weights
#' @export
#'
#' @examples
#' calc_bic_weights(c(21, 20, 15, 24))
calc_bic_weights <- function(bics) {

  best_model_bic <- min(bics)
  weights <- exp(-0.5 * (bics - best_model_bic))
  weights <- weights / sum(weights)
  testit::assert(
    fact = "BIC weights must sum to 1",
    isTRUE(all.equal(sum(weights), 1L))
  )
  weights
}
