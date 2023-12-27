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

# 2 archipelagos plots m_19

models_to_plot <- list(m_17, m_18, m_19)
models <- c(17, 18, 19)
rates_plots_lord_howe <- list()
rates_plots_galapagos <- list()
for (i in seq_along(models)) {
  model_res <- models_to_plot[[i]]
  model <- models[i]

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
  j <- 20 # Lord Howe
  area_plot_lord_howe <- ggplot2::ggplot(base_rates[[j]]) +
    ggplot2::geom_line(ggplot2::aes(age, area)) +
    ggplot2::theme_classic() +
    ggplot2::xlab("Time before present") +
    ggplot2::ylab("Area km\U00B2") +
    ggplot2::coord_cartesian(ylim = c(0, NA)) +
    ggplot2::ggtitle("Lord Howe") +
    ggplot2::theme(legend.title = ggplot2::element_blank(),
                   axis.title.x = ggplot2::element_blank())
  rates_plots_lord_howe[[i]] <- plot_line_estimates(base_rates[[j]], log_gamma = FALSE)
  rates_plots_lord_howe[[i]] <- rates_plots_lord_howe[[i]] +
    ggplot2::theme_classic() +
    ggplot2::ggtitle(paste0("M", models[i])) +
    ggplot2::theme(legend.title = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_text(size = 10),
                   title = ggplot2::element_text(size = 10),
                   plot.title = ggplot2::element_text(hjust = 1, size = 10),
                   axis.title.x = ggplot2::element_text(size = 10))
  if (i < 3) {
    rates_plots_lord_howe[[i]] <- rates_plots_lord_howe[[i]] +
      ggplot2::theme(axis.title.x = ggplot2::element_blank())
  }



  # plot
  j <- 13 # Galapagos
  area_plot_galapagos <- ggplot2::ggplot(base_rates[[j]]) +
    ggplot2::geom_line(ggplot2::aes(age, area)) +
    ggplot2::theme_classic() +
    ggplot2::xlab("Time before present") +
    ggplot2::ylab("Area km\U00B2") +
    ggplot2::coord_cartesian(ylim = c(0, NA)) +
    ggplot2::ggtitle("Galápagos") +
    ggplot2::theme(legend.title = ggplot2::element_blank(),
                   axis.title.x = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_blank())


  rates_plots_galapagos[[i]] <- plot_line_estimates(ordered_results = base_rates[[j]], log_gamma = FALSE)
  rates_plots_galapagos[[i]] <- rates_plots_galapagos[[i]] +
    ggplot2::theme_classic() +
    ggplot2::ggtitle(paste0("M", models[i])) +
    ggplot2::theme(legend.title = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_blank(),
                   plot.title = ggplot2::element_text(hjust = 1, size = 10),
                   axis.title.x = ggplot2::element_text(size = 10))
  if (i < 3) {
    rates_plots_galapagos[[i]] <- rates_plots_galapagos[[i]] +
      ggplot2::theme(axis.title.x = ggplot2::element_blank())
  }
}

final_plot <- (((area_plot_lord_howe / rates_plots_lord_howe[[1]] / rates_plots_lord_howe[[2]] / rates_plots_lord_howe[[3]]) + patchwork::plot_layout(tag_level = "new") |
                 (area_plot_galapagos / rates_plots_galapagos[[1]] / rates_plots_galapagos[[2]] / rates_plots_galapagos[[3]]) + patchwork::plot_layout(tag_level = "new"))) +
  patchwork::plot_layout(guides = "collect") +
  patchwork::plot_annotation(tag_levels = c("A", "1")) &
  ggplot2::theme(legend.position = 'bottom', legend.text = ggtext::element_markdown())
save_paper_plot(final_plot, "galapagos_lord_howe")


