library(tidyverse)

area_global_cutler <- read_csv("data-raw/area_global_cutler.csv")

area_global_cutler_grouped <- area_global_cutler %>% group_by(archipelago)
cutler_summed_unique_areas <- area_global_cutler_grouped %>%
  group_by(archipelago) %>%
  summarise_if(is.numeric, function(x) sum(unique(na.omit(x))))




largest_arch <- max(
  as.numeric(
    summarise_if(
      .tbl = cutler_summed_unique_areas, .predicate = is.numeric,.funs = max)), na.rm = TRUE)

# ggplot2::ggplot(cutler_summed_unique_areas, aes(y = Aladraba, x = Aladraba))

x_axis <- 1:141


plot(
  y = log(cutler_summed_unique_areas[1, 2:142]),
  x = x_axis,
  type = "l",
  ylim = c(0, largest_arch),
  ylab = "Archipelago area km^2",
  xlab = "Ky before present",
  main = "Paleo-area through time"
)
for (i in 2:(nrow(cutler_summed_unique_areas))) {
  lines(y = cutler_summed_unique_areas[i, 2:142], x, type = "l")
}
