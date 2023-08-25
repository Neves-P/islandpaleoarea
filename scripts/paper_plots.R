data("ordered_results_paleo")

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
m_19 <- ordered_results_paleo |> dplyr::filter(model == 19)
m_19 <- cbind(m_19, total_area = total_area[m_19$age])

m_18 <- ordered_results_paleo |> dplyr::filter(model == 18)
m_18 <- cbind(m_18, total_area = total_area[m_18$age])

m_17 <- ordered_results_paleo |> dplyr::filter(model == 17)
m_17 <- cbind(m_17, total_area = total_area[m_17$age])

global_estimate_plots_19 <- plot_line_estimates(ordered_results = m_19, log_gamma = TRUE)
global_area_plot_19 <- plot_area_time(m_19)

global_estimate_plots_18 <- plot_line_estimates(ordered_results = m_18, log_gamma = TRUE)
global_area_plot_18 <- plot_area_time(m_18)

global_estimate_plots_17 <- plot_line_estimates(ordered_results = m_17, log_gamma = TRUE)
global_area_plot_17 <- plot_area_time(m_17)

# 2 archipelagos plots
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

# plot
i <- 20 # Lord Howe
area_plot_lord_howe <- ggplot2::ggplot(base_rates[[i]]) +
  ggplot2::geom_line(ggplot2::aes(age, area)) +
  ggplot2::theme_classic() +
  ggplot2::xlab("Time before present") +
  ggplot2::ylab("Area") +
  ggplot2::coord_cartesian(ylim = c(0, NA)) +
  # ggplot2::scale_y_log10(breaks = scales::trans_breaks("log10", function(x) 10^x),
  #               labels = scales::trans_format("log10", scales::math_format(10^.x))) +
  # ggplot2::scale_y_continuous(
  #   trans = "log10", labels = scales::math_format(10^.x, format = log10)
  # ) +
  ggplot2::theme(legend.title = ggplot2::element_blank(), axis.title = ggplot2::element_blank()) +
  ggplot2::ggtitle(gsub("_", " ", names(base_rates[i])))
rates_plots_lord_howe <- plot_line_estimates(base_rates[[i]], log_gamma = FALSE)
rates_plots_lord_howe <- rates_plots_lord_howe +
  ggplot2::theme_classic() +
  ggplot2::xlab("Time before present")


# plot
i <- 13 # Galapagos
area_plot_lord_galapagos <- ggplot2::ggplot(base_rates[[i]]) +
  ggplot2::geom_line(ggplot2::aes(age, area)) +
  ggplot2::theme_classic() +
  ggplot2::xlab("Time before present") +
  ggplot2::ylab("Area") +
  ggplot2::coord_cartesian(ylim = c(0, NA)) +
  # ggplot2::scale_y_log10(breaks = scales::trans_breaks("log10", function(x) 10^x),
  #               labels = scales::trans_format("log10", scales::math_format(10^.x))) +
  # ggplot2::scale_y_continuous(
  #   trans = "log10", labels = scales::math_format(10^.x, format = log10)
  # ) +
  ggplot2::theme(legend.title = ggplot2::element_blank(), axis.title = ggplot2::element_blank()) +
  ggplot2::ggtitle(gsub(pattern = "_", replacement =  " ", x = names(base_rates[i])))
rates_plots_galapagos <- plot_line_estimates(ordered_results = base_rates[[i]], log_gamma = FALSE)
rates_plots_galapagos <- rates_plots_galapagos +
  ggplot2::theme_classic() +
  ggplot2::xlab("Time before present")

((global_area_plot_19 / global_estimate_plots_19) | ((area_plot_lord_howe + rates_plots_lord_howe) / (area_plot_lord_galapagos + rates_plots_galapagos))) + patchwork::plot_layout(guides = "collect")
