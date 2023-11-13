data("ordered_results_paleo_minus_outliers")

# Total area and pars plots
total_area <- c()
total_distance <- c()
for (time_slice in seq_along(archipelagos41_paleo)) {
  area <- c()
  distance <- c()
  for (archipelago in seq_along(archipelagos41_paleo[[time_slice]])) {
    area <- c(area, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$area)
    distance <- c(distance, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$distance_continent)

  }
  total_area[time_slice] <- sum(area)
}
m_19 <- ordered_results_paleo_minus_outliers |> dplyr::filter(model == 19)
m_19 <- cbind(m_19, total_area = total_area[m_19$age])

m_18 <- ordered_results_paleo_minus_outliers |> dplyr::filter(model == 18)
m_18 <- cbind(m_18, total_area = total_area[m_18$age])

m_17 <- ordered_results_paleo_minus_outliers |> dplyr::filter(model == 17)
m_17 <- cbind(m_17, total_area = total_area[m_17$age])

global_estimate_plots_19 <- plot_line_estimates(ordered_results = m_19, log_gamma = TRUE)
global_area_plot_19 <- plot_area_time(m_19)

global_estimate_plots_18 <- plot_line_estimates(ordered_results = m_18, log_gamma = TRUE)
global_area_plot_18 <- plot_area_time(m_18)

global_estimate_plots_17 <- plot_line_estimates(ordered_results = m_17, log_gamma = TRUE)
global_area_plot_17 <- plot_area_time(m_17)

# 2 archipelagos plots m_19
model_res <- m_19
model <- 19
names(archipelagos41_paleo[[1]])
areas <- list()
distances <- list()
for (archipelago in names(archipelagos41_paleo[[1]])) {
  area <- c()
  distance <- c()
  for (time_slice in model_res$age) {
    area <- c(area, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$area)
    distance <- c(distance, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$distance_continent)
  }
  areas[[archipelago]] <- area
  distances[[archipelago]] <- distance
}
base_rates <- list()
for (archipelago in names(archipelagos41_paleo[[1]])) {
  base_rates[[archipelago]] <- get_base_rates(
    archipelago_data = archipelagos41_paleo[[1]][[archipelago]][[1]],
    M = 1000,
    pars_res_df = model_res,
    model = model,
    area = areas[[archipelago]],
    distance = distances[[archipelago]]
  )
}
for (archipelago in names(archipelagos41_paleo[[1]])) {
  base_rates[[archipelago]]$age <- model_res$age
}


final_plot <- (global_area_plot_19 + global_estimate_plots_19) +
  patchwork::plot_layout(guides = "collect", widths = c(1, 2)) +
  patchwork::plot_annotation(tag_levels = "A")


save_paper_plot(final_plot, "rates_areas_plots_minus_outliers")

