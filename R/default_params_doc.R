#' Default parameter documentation to inherit from
#'
#' @param results_path A string with valid path for folder containing model
#' fitting results as obtained from runs on Peregrine HPCC via the contained
#' R and bash scripts on this package.
#' @param archipelago_data List with DAISIE data for one of the considered
#'  archipelagos
#' @param pars Numeric vector with CES rates and K: lamda_c, mu, K, gamma, lambda_a
#' @param model Numeric integer or vector of integers:
#'  model number as described in Valente et al 2020.
#' @param M Numeric, number of mainland species
#' @param pars_res_df Data frame with results of one model for all archipelagos
#'   and ages
#' @param ordered_results Data frame with all the results, BIC and BIC weights ordered
#' by age and model for all archipelagos
#' @param best_models A numeric vector with the numbers of the parameters to be plotted
#' @param standardisation String which can be `"difference"` or `"ratio"`, or defaults to `FALSE`.
#' `"difference"` standardises estimated parameters by taking the difference of
#' each time point in relation to the first time point, `"ratio"` does the same
#' but takes the ratio as opposed to the difference and `FALSE` presents the
#' absolute estimates
#'
#' @return Nothing
#' @export
#' @keywords internal
#'
#' @author Pedro Santos Neves
default_params_doc <- function(results_path,
                               archipelago_data,
                               pars,
                               model,
                               M,
                               pars_res_df,
                               ordered_results,
                               best_models,
                               standardisation) {
  # nothing
}
