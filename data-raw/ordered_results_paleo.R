## code to prepare `ordered_results_paleo` dataset goes here

data("results_paleo", package = "islandpaleoarea")

ordered_results_paleo <- results_paleo |>
  dplyr::mutate(bic = calc_bic(loglik, df, 1000)) |>
  dplyr::group_by(age, model) |>
  dplyr::arrange(dplyr::desc(bic), .by_group = TRUE) |>
  dplyr::slice_min(order_by = bic) |>
  dplyr::group_by(age) |>
  dplyr::mutate(bic_weights = calc_bic_weights(bic)) |>
  dplyr::mutate(model = as.factor(model))

usethis::use_data(ordered_results_paleo, overwrite = TRUE)
