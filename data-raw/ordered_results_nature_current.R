## code to prepare `ordered_results_nature_current` dataset goes here

data("results_nature_current", package = "islandpaleoarea")

ordered_results_nature_current <- results_nature_current |>
  dplyr::mutate(bic = calc_bic(loglik, df, 1000)) |>
  dplyr::group_by(model) |>
  dplyr::arrange(dplyr::desc(bic), .by_group = TRUE) |>
  dplyr::slice_min(bic) |>
  dplyr::mutate(model = as.factor(model))


usethis::use_data(ordered_results_nature_current, overwrite = TRUE)
