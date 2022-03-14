library(tidyverse)
area_cutler <- read.csv("data-raw/area_cutler20220211.csv")
with_hawaii <- ggplot(area_cutler, aes(x = year_before_after_present, y = area_km, color = archipelago_name)) +
  geom_line()
ggsave(
  plot = with_hawaii,
  filename = "arch_area_with_hawaii.pdf",
  device = "pdf",
  width = 25,
  height = 14,
  units = "cm"
)

 area_cutler %>%
  filter(archipelago_name != 'Hawaii') %>%
ggplot(aes(x = year_before_after_present, y = area_km, color = archipelago_name)) +
  geom_line()
area_cutler %>%
  filter(archipelago_name != 'Hawaii') %>%
ggplot(aes(x = year_before_after_present, y = area_km, color = archipelago_name)) +
  geom_line() + scale_y_continuous(trans = "log2", name = "log2(Archipelago area km^2)")

# Cutler Distortion

ggplot(area_cutler_distortion, aes(x = year_before_after_present, y = area_km, color = archipelago_name)) +
geom_line()

area_cutler_distortion %>%
  filter(archipelago_name != 'Hawaii') %>%
  ggplot(aes(x = year_before_after_present, y = area_km, color = archipelago_name)) +
  geom_line()

area_cutler_distortion %>%
  filter(archipelago_name != 'Hawaii') %>%
  ggplot(aes(x = year_before_after_present, y = area_km, color = archipelago_name)) +
  geom_line() + scale_y_continuous(trans = "log2", name = "log2(Archipelago area km^2)")

