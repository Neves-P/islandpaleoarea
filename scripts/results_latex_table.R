
# We make all BIC weights < 0.01 be 0.0, to then grep and convert to *
ordered_results_paleo_selected <- ordered_results_paleo |>
  dplyr::select(c(age, model,  bic_weights)) |>
  dplyr::mutate(bic_weights = dplyr::if_else(bic_weights < 0.01, 0.0, bic_weights))



age_model_table <- ordered_results_paleo_selected |>
  tidyr::pivot_wider(names_from = model,
                     values_from = bic_weights)



latex_table <- xtable::xtable(age_model_table[,17:19], digits = 2)


