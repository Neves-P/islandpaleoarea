data("archipelagos41_paleo")
names(archipelagos41_paleo[[1]])
areas <- list()
areas_ratio <- list()
plotabble_ratios <- data.frame("archipelago" = NA, "ratio" = NA)
model_res <- dplyr::filter(ordered_results_paleo, model == 19)

for (archipelago in names(archipelagos41_paleo[[1]])) {
  area <- c()
  area_ratio <- c()
  distance <- c()

  for (time_slice in model_res$age) {
    area <- c(area, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$area)

  }
  areas_ratio[[archipelago]] <- area / area[1]
  areas[[archipelago]] <- area
  plotabble_ratios <- rbind(plotabble_ratios, data.frame("archipelago" = rep(archipelago, 141), "ratio" = areas_ratio[[archipelago]]))
}


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
ggplot2::ggplot(plotabble_ratios, ggplot2::aes(archipelago, ratio)) +
  ggplot2::geom_boxplot() +
  ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(angle = 90))

lapply(X = areas_ratio, plot)
lapply(X = areas_ratio, boxplot)
plot(unlist(lapply(X = areas_ratio, sd)), ylab = "SD of (area / area at the present)")


