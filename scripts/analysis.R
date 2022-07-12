results <- read_results(file.path("results", "archipelagos41_paleo"))

ordered_results <- results |>
  dplyr::mutate(bic = calc_bic(loglik, df, 1000)) |>
  dplyr::group_by(age) |>
  dplyr::arrange(dplyr::desc(bic), .by_group = TRUE) |> dplyr::slice_min(bic)

View(ordered_results)


