## code to prepare `ordered_results_paleo` dataset goes here

ordered_results_paleo <- results_paleo |>
  dplyr::mutate(bic = calc_bic(loglik, df, 1000)) |>
  dplyr::group_by(age) |>
  dplyr::arrange(dplyr::desc(bic), .by_group = TRUE) |> dplyr::slice_min(bic)

usethis::use_data(ordered_results_paleo, overwrite = TRUE)
