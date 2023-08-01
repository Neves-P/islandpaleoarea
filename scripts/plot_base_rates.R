
model <- 19
model_res <- dplyr::filter(ordered_results_paleo, model == 19)

# pars_res_df <- data.frame(
#   age = model_res$age,
#   lambda_c0 = model_res$lambda_c0,
#   mu_0 = model_res$mu_0,
#   K_0 = model_res$K_0,
#   gamma_0 = model_res$gamma_0,
#   lambda_a0 = model_res$lambda_a0,
#   x = model_res$x,
#   y = model_res$y,
#   z = model_res$z,
#   alpha = model_res$alpha,
#   beta = model_res$beta,
#   d0 = model_res$d_0,
#   loglik = model_res$loglik
# )

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


out_diff <- facet_archipelagos(base_rates, standardisation = "difference")
out_ratio <- facet_archipelagos(base_rates, standardisation = "ratio")
out <- facet_archipelagos(base_rates, standardisation = FALSE)
library(Cairo)
ggplot2::ggsave("combined_diff_log10.pdf", out_diff, width = 30, height = 10, device = cairo_pdf)
ggplot2::ggsave("combined_ratio_log10.pdf", out_ratio, width = 30, height = 10, device = cairo_pdf)
ggplot2::ggsave("combined_log10.pdf", out, width = 30, height = 10, device = cairo_pdf)

# mu_0 and x fixed as present parameter, let area change with time, plot again
# other parameters too?
# y axis on








# Combine single arch plots with area curve
# Plot also the hyperparameters per model
# If applicable, choose then one model to look across
# If hyperparameters are stable, then area is driving the change
# Area and base parameters through time in plot. Will have to rescale. Main point is: do parameters follow area?


# Choose 1 model for which
# 1 Plot with Hyperpars as function of age
# 41 Plot with archipelago rates and areas as function of age
# Combine in 6x7

# Overlay area

rates_plots <- list()
combined_plots <- list()
# area_plots <- list()
hyperpars_plots <- list()
for(i in 1:41) {
  rates_plots[[i]] <- plot_line_estimates(base_rates[[i]])


  rates_plots[[i]] <- rates_plots[[i]] +
    # ggplot2::ggplot(base_rates[[i]]) +
    ggplot2::geom_line(ggplot2::aes(age, x, colour = "x")) +
    ggplot2::geom_line(ggplot2::aes(age, d0, colour = "d0")) +
    ggplot2::geom_line(ggplot2::aes(age, beta, colour = "beta")) +
    ggplot2::geom_line(ggplot2::aes(age, alpha, colour = "alpha")) +
    ggplot2::geom_line(ggplot2::aes(age, area)) +
    ggplot2::theme_classic() +
    ggplot2::xlab("Time before present") +
    ggplot2::ylab("Hyperparameter")



combined_plots[[i]] <- (area_plots[[i]] + rates_plots[[i]] +
                          patchwork::plot_annotation(
                            title = paste0(gsub("_", " ", names(base_rates[i]), "_"), " m ", model)
                          )) +
  ggplot2::scale_fill_continuous(guide = ggplot2::guide_legend()) +
  ggplot2::theme(legend.position = "bottom")
}



# 1 plot with hyperparameters through time (global) plus area. This plot is global, as
# set of hyperpars is global by definition
# Set of model estimates per archipelago (4 or 5, 41 times, one per archipelago)
# Plot of loglikelihood through time. Is peak in LL the better one? In a panel hyperpars plot
# Make 3 versions of plots above for each of the 3 best models. Some go in suppmat, others are panels
# Plot with overlay of all 41 areas


# Hyperpars plot

## Add here global area plot?
global_area_time <- c()
data("ordered_results_paleo")


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
hyperpars_df <- data.frame(base_rates[[1]], total_area)
max_hyperpars <- max(
  hyperpars_df$x,
  hyperpars_df$d0,
  hyperpars_df$beta,
  hyperpars_df$alpha
)
peak_area <- max(total_area)
scale_factor <- peak_area / max_hyperpars
hyperpars_plot <- ggplot2::ggplot(hyperpars_df) +
  ggplot2::geom_line(ggplot2::aes(age, x, colour = "x")) +
  ggplot2::geom_line(ggplot2::aes(age, d0, colour = "d0")) +
  ggplot2::geom_line(ggplot2::aes(age, beta, colour = "beta")) +
  ggplot2::geom_line(ggplot2::aes(age, alpha, colour = "alpha")) +
  ggplot2::geom_line(ggplot2::aes(age, total_area / scale_factor, colour = "total area")) +
  ggplot2::scale_y_continuous(
    name = "Hyperparameters",
    sec.axis = ggplot2::sec_axis(~.*scale_factor, name = "Area")
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.title = ggplot2::element_blank()) +
  ggplot2::xlab("Time before present") +
  ggplot2::ylab("Hyperparameter")
hyperpars_plot


# LL plot
loglik_plot <- ggplot2::ggplot(pars_res_df) +
  ggplot2::geom_line(ggplot2::aes(age, loglik, colour = "loglik")) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.title = ggplot2::element_blank()) +
  ggplot2::xlab("Time before present") +
  ggplot2::ylab("Loglikelihood")

