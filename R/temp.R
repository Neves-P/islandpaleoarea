ordered_results_paleo <- results_paleo |>
  dplyr::mutate(bic = calc_bic(loglik, df, 1000)) |>
  dplyr::group_by(age, model) |>
  dplyr::arrange(dplyr::desc(bic), .by_group = TRUE) |>
  dplyr::slice_min(order_by = bic)

ordered_results_paleo <- ordered_results_paleo |>
  dplyr::group_by(age) |>
  dplyr::mutate(bic_weights = calc_bic_weights(bic)) |>
  dplyr::mutate(model = as.factor(model))

best_models <- c(17, 19, 4, 18)

df_to_plot <- ordered_results_paleo |> dplyr::mutate(model = function(x) {
  if (!(x %in% best_models)) 0
})


ggplot2::ggplot(ordered_results_paleo,
                ggplot2::aes(x = age, y = bic_weights, fill = model)) +
  ggplot2::geom_area()



