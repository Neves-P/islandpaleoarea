global_area_time <- c()
data("ordered_results_paleo")


for (model_num in 17:19) {


  model_res <- dplyr::filter(ordered_results_paleo, model == model_num)


  # Get individual archipelago areas
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

  # Get base rates
  base_rates <- list()
  for (archipelago in names(archipelagos41_paleo[[1]])) {
    base_rates[[archipelago]] <- get_base_rates(
      archipelago_data = archipelagos41_paleo[[1]][[archipelago]][[1]],
      M = 1000,
      pars_res_df = model_res,
      model = model_num,
      area = areas[[archipelago]],
      distance = distances[[archipelago]]
    )
  }
  for (archipelago in names(archipelagos41_paleo[[1]])) {
    base_rates[[archipelago]]$age <- model_res$age
  }

  # Get present area / past areas
  data("archipelagos41_paleo")
  names(archipelagos41_paleo[[1]])
  areas <- list()
  areas_ratio <- list()
  model_res <- dplyr::filter(ordered_results_paleo, model == model_num)

  for (archipelago in names(archipelagos41_paleo[[1]])) {
    area <- c()
    area_ratio <- c()
    distance <- c()

    for (time_slice in model_res$age) {
      area <- c(area, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$area)

    }
    areas_ratio[[archipelago]] <- area / area[1]
    areas[[archipelago]] <- area
  }

  # Get SD and mean of ratios from above
  ratios_time_slice_sds <- c()
  ratios_time_slice_mean <- c()
  ratios_time_slices <- list()
  ratios_time_slices_df <- data.frame()
  for (i in seq_along(areas$Aldabra_Group)) { # loops over time slice
    ratios_time_slice <- c()
    archipelago_names <- c()
    for (j in seq_along(areas)) { # seq_along(areas) loops over archipelagos
      ratios_time_slice <- c(ratios_time_slice, areas[[j]][i] / areas[[j]][1])
      archipelago_names <- c(archipelago_names, names(areas[j]))
    }
    times <- rep(i, length(areas))
    temp_df <- data.frame(archipelago_names, times, ratios_time_slice)
    ratios_time_slices_df <- rbind(ratios_time_slices_df, temp_df)

    ## Older calculations
    ratios_time_slice_sds[i] <- sd(ratios_time_slice)
    ratios_time_slice_mean[i] <- mean(ratios_time_slice)
  }
  colnames(ratios_time_slices_df) <- c("Archipelagos", "Times", "Ratios")
  ratios_time_slices_df$Archipelagos <- gsub('_', ' ', ratios_time_slices_df$Archipelagos)
  line_plot <- ggplot2::ggplot(ratios_time_slices_df, ggplot2::aes(Times, Ratios, colour = Archipelagos)) +
    ggplot2::geom_line()
  save_paper_plot(line_plot, "ratios_line")
  ratios_time_slices_df <- dplyr::group_by(ratios_time_slices_df, Archipelagos)

  box_plot <- ggplot2::ggplot(ratios_time_slices_df, ggplot2::aes(Archipelagos, Ratios)) +
    ggplot2::geom_boxplot() +
    ggplot2::geom_jitter() +
    ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(angle = 45)) +
    ggplot2::theme_classic()
  save_paper_plot(box_plot, "box_plot")
  # Get total areas
  total_area <- c()
  total_distance <- c()
  for (time_slice in seq_along(base_rates[[1]]$age)) { # Loop over ages for which there is data in all models
    area <- c()
    distance <- c()
    for (archipelago in seq_along(archipelagos41_paleo[[time_slice]])) {
      area <- c(area, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$area)
      distance <- c(distance, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$distance_continent)

    }
    total_area[time_slice] <- sum(area)
  }



  # Get hyperparameters (from first archipelago, they are always the same value in all of them)
  hyperpars_df <- data.frame(base_rates[[1]], total_area, ratios_time_slice_sds)
  max_hyperpars <- max(
    hyperpars_df$x,
    hyperpars_df$d_0,
    hyperpars_df$beta,
    hyperpars_df$alpha
  )

  #### Plots ####
  hyperpars_plot_mean_sd <- ggplot2::ggplot(hyperpars_df) +
    ggplot2::geom_line(ggplot2::aes(age, x, colour = "*x*")) +
    ggplot2::geom_line(ggplot2::aes(age, d_0 / max_hyperpars, colour = "*d\U2080*")) +
    ggplot2::geom_line(ggplot2::aes(age, alpha, colour = "*\U003B1*")) +
    ggplot2::geom_line(ggplot2::aes(age, beta, colour = "*\U03B2*")) +
    ggplot2::scale_y_continuous(
      name = "Hyperparameter value",
      sec.axis = ggplot2::sec_axis(~.*max_hyperpars, name = "d\U2080")
    ) +
    ggplot2::theme_classic() +
    ggplot2::theme(legend.title = ggplot2::element_blank(),
                   legend.text = ggtext::element_markdown(),
                   plot.title = ggplot2::element_blank()) +
    ggplot2::xlab("Time before present")
  if (model_num != 19) {
    hyperpars_plot_mean_sd <- hyperpars_plot_mean_sd + ggplot2::geom_line(ggplot2::aes(age, y, colour = "y"))
  }
  save_paper_plot(plot_to_save = hyperpars_plot_mean_sd, file_name = paste0("hyperpars_area_sd_area_ratio", "_", model_num))

}

# Composite figure source(paper_plots.R) first

final_plot <- (global_area_plot_19 + ggplot2::xlab("Time before present") + ggplot2::theme(axis.title.x = ggplot2::element_text(size = 9)) +
                 global_estimate_plots_19 + ggplot2::theme(plot.title = ggplot2::element_blank(), axis.title.x = ggplot2::element_text(size = 9)) +
                 hyperpars_plot_mean_sd) + ggplot2::theme(axis.title.x = ggplot2::element_text(size = 9)) +
  patchwork::plot_layout(guides = "collect") +
  patchwork::plot_annotation(tag_levels = "A")
# save_paper_plot(final_plot, "m19_pars_hyperpars", type_size = "half_size")
ggplot2::ggsave(plot = final_plot, filename = "figures/m19_pars_hyperpars.png", device = "png", width = 150, height = 60, units = "mm")
ggplot2::ggsave(plot = final_plot, filename = "figures/m19_pars_hyperpars.pdf", device = "pdf", width = 150, height = 60, units = "mm")
