library(tidyverse)

area_global_cutler <- read_csv("data-raw/area_cutler20220211.csv")

area_global_cutler_grouped <- area_global_cutler %>% group_by(archipelago_name)
cutler_summed_unique_areas <- area_global_cutler_grouped %>%
  group_by(archipelago_name) %>%
  summarise_if(is.numeric, function(x) sum(unique(na.omit(x))))




largest_arch <- max(
  as.numeric(
    summarise_if(
      .tbl = cutler_summed_unique_areas, .predicate = is.numeric,.funs = max)), na.rm = TRUE)

ggplot2::ggplot(cutler_summed_unique_areas, aes(y = Aladraba, x = Aladraba))

x_axis <- 1:141


plot(
  y = log(cutler_summed_unique_areas[1, 2:142]),
  x = x_axis,
  type = "l",
  ylim = c(0, log(largest_arch)),
  ylab = "log(Archipelago area km^2)",
  xlab = "Ky before present",
  main = "Paleo-area through time",
  lwd = 2
)
for (i in 2:(nrow(cutler_summed_unique_areas))) {
  lines(y = log(cutler_summed_unique_areas[i, 2:142]), x_axis, type = "l", col = i,
        lwd = 2)
}



# legend(
#   "bottomleft",
#   legend = c(cutler_summed_unique_areas[, 1])$archipelago,
#   col = 1:28,
#   lty = 1,
#   ncol = 5
# )
out_vec <- c()
for (i in 3:ncol(cutler_summed_unique_areas)) {
  out_vec[i - 3] <- cor(cutler_summed_unique_areas[, 2], cutler_summed_unique_areas[, i])

}
plot(
  out_vec,
  type = "l",
  ylab = "Correlation coeficient vs current area",
  ylim = c(0, 1),
  xlab = "Ky before present",
  main = "Pearson correlation between current area and paleo area",
  lwd = 2
)

# Minus outliers
cutler_summed_unique_areas_no_outliers <- cutler_summed_unique_areas[-21, ]
cutler_summed_unique_areas_no_outliers <- cutler_summed_unique_areas_no_outliers[-14, ]


plot(
  y = log(cutler_summed_unique_areas_no_outliers[1, 2:142]),
  x = x_axis,
  type = "l",
  ylim = c(0, log(largest_arch)),
  ylab = "log(Archipelago area km^2)",
  xlab = "Ky before present",
  main = "Paleo-area through time",
  lwd = 2
)
for (i in 2:(nrow(cutler_summed_unique_areas_no_outliers))) {
  lines(y = log(cutler_summed_unique_areas_no_outliers[i, 2:142]), x_axis, type = "l", col = i,
        lwd = 2)
}


out_vec <- c()
for (i in 3:ncol(cutler_summed_unique_areas_no_outliers)) {
  out_vec[i - 3] <-
    cor(
      cutler_summed_unique_areas_no_outliers[, 2],
      cutler_summed_unique_areas_no_outliers[, i]
    )

}
plot(
  out_vec,
  type = "l",
  ylab = "Pearson coefficient",
  ylim = c(0, 1),
  xlab = "Ky before present",
  main = "Correlation between current area and paleo area sans outliers",
  lwd = 2
)
