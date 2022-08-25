data("ordered_results_paleo")


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
m_15 <- ordered_results_paleo |> dplyr::filter(model == 15)
m_15 <- cbind(m_15, total_area = total_area[m_15$age])

m_15_plot <- plot_res_area(m_15)
save_paper_plot(plot_to_save = m_15_plot, file_name = "m_15_plot")

m_16 <- ordered_results_paleo |> dplyr::filter(model == 16)
m_16 <- cbind(m_16, total_area = total_area[m_16$age])

m_16_plot <- plot_res_area(m_16)
save_paper_plot(plot_to_save = m_16_plot, file_name = "m_16_plot")

m_17 <- ordered_results_paleo |> dplyr::filter(model == 17)
m_17 <- cbind(m_17, total_area = total_area[m_17$age])

m_17_plot <- plot_res_area(m_17)
save_paper_plot(plot_to_save = m_17_plot, file_name = "m_17_plot")

m_18 <- ordered_results_paleo |> dplyr::filter(model == 18)
m_18 <- cbind(m_18, total_area = total_area[m_18$age])

m_18_plot <- plot_res_area(m_18)

save_paper_plot(plot_to_save = m_18_plot, file_name = "m_18_plot")
