global_area_time <- c()
data("ordered_results_paleo")



for (model_num in 17:19) {


model_res <- dplyr::filter(ordered_results_paleo, model == model_num)


# Get individual archipelago areas
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
for (i in seq_along(areas$Aldabra_Group)) {
  ratios_time_slice <- c()
  for (j in seq_along(areas)) {
    ratios_time_slice <- c(ratios_time_slice, areas[[j]][i] / areas[[j]][1])
  }
  ratios_time_slice_sds[i] <- sd(ratios_time_slice)
  ratios_time_slice_mean[i] <- mean(ratios_time_slice)
}

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
ratios <- ratios_time_slice_sds  / ratios_time_slice_mean
scale_factor_ratios <- max(ratios) / max_hyperpars
hyperpars_plot_mean_sd <- ggplot2::ggplot(hyperpars_df) +
  ggplot2::geom_line(ggplot2::aes(age, x, colour = "x")) +
  ggplot2::geom_line(ggplot2::aes(age, d_0, colour = "d\U2080")) +
  ggplot2::geom_line(ggplot2::aes(age, alpha, colour = "\U003B1")) +
  ggplot2::geom_line(ggplot2::aes(age, beta, colour = "\U03B2")) +
  ggplot2::geom_line(ggplot2::aes(age, ratios / scale_factor_ratios, colour = "\U03C3 A / \U0100")) +
  # ggplot2::geom_line(ggplot2::aes(age, ratios_time_slice_sds, colour = "Ratio SD")) +
  ggplot2::scale_y_continuous(
    name = "Hyperparameter value",
    sec.axis = ggplot2::sec_axis(~.*scale_factor_ratios, name = "\U03C3 A / \U0100")
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.title = ggplot2::element_blank()) +
  ggplot2::xlab("Time before present")
if (model_num != 19) {
  hyperpars_plot_mean_sd <- hyperpars_plot_mean_sd + ggplot2::geom_line(ggplot2::aes(age, y, colour = "y"))
}
save_paper_plot(plot_to_save = hyperpars_plot_mean_sd, file_name = paste0("hyperpars_area_sd_area_ratio", "_", model_num))


#areas sd plot
peak_area <- max(total_area)
scale_factor <- peak_area / max(ratios)
areas_sd_ratio <- ggplot2::ggplot(hyperpars_df) +
  ggplot2::geom_line(ggplot2::aes(age, total_area / scale_factor, colour = "Total area")) +
  ggplot2::geom_line(ggplot2::aes(age, ratios, colour = "\U03C3 A / \U0100")) +
  ggplot2::scale_y_continuous(
    name = "\U03C3 A / \U0100",
    sec.axis = ggplot2::sec_axis(~.*scale_factor, name = "Total area km\U00B2")
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.title = ggplot2::element_blank()) +
  ggplot2::xlab("Time before present")
save_paper_plot(plot_to_save = areas_sd_ratio, file_name = paste0("area_sd_ratio", "_", model_num))
}
