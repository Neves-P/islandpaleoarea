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
m_19 <- ordered_results_paleo |> dplyr::filter(model == 19)
m_19 <- cbind(m_19, total_area = total_area[m_19$age])

m_19_plot <- plot_res_area(m_19)
save_paper_plot(plot_to_save = m_19_plot, file_name = "m_19_plot")

m_17 <- ordered_results_paleo |> dplyr::filter(model == 17)
m_17 <- cbind(m_17, total_area = total_area[m_17$age])

m_17_plot <- plot_res_area(m_17)
save_paper_plot(plot_to_save = m_17_plot, file_name = "m_17_plot")

m_18 <- ordered_results_paleo |> dplyr::filter(model == 18)
m_18 <- cbind(m_18, total_area = total_area[m_18$age])

m_18_plot <- plot_res_area(m_18)

save_paper_plot(plot_to_save = m_18_plot, file_name = "m_18_plot")
