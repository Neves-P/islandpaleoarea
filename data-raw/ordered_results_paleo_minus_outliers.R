## code to prepare `ordered_results_paleo_minus_outliers` dataset goes here

data("results_paleo_minus_outliers", package = "islandpaleoarea")

ordered_results_paleo_minus_outliers <- results_paleo_minus_outliers |>
  dplyr::mutate(bic = calc_bic(loglik, df, 1000)) |>
  dplyr::group_by(age, model) |>
  dplyr::arrange(dplyr::desc(bic), .by_group = TRUE) |>
  dplyr::slice_min(bic) |>
  dplyr::group_by(age) |>
  dplyr::mutate(bic_weights = calc_bic_weights(bic)) |>
  dplyr::mutate(model = as.factor(model))

usethis::use_data(ordered_results_paleo_minus_outliers, overwrite = TRUE)
