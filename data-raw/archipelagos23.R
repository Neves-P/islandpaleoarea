## code to prepare `archipelagos41_paleo` dataset goes here

data(archipelagos41, package = "DAISIE")
archipelagos_paleo_area <- readr::read_csv(
  "data-raw/area_cutler20220211.csv"
)
archipelago_names <- c()
areas <- c()
area_comp <- data.frame(archipelago = character(), areas = numeric())
for (i in seq_along(archipelagos41)) {
  area_comp[i, 1] <- archipelagos41[[i]][[1]]$name
  area_comp[i, 2] <- archipelagos41[[i]][[1]]$area
}

new_areas <- dplyr::group_by(area_cutler20220211, archipelago_name) |>
  dplyr::filter(year_before_after_present == 0) |>
  dplyr::arrange(archipelago_name) |>
  dplyr::select(archipelago_name, area_km)
out <- cbind(area_comp, new_areas)

for (i in seq_along(archipelagos41)) {
  areas[i] <- archipelagos41[[i]][[1]]$area
}

dplyr::filter(archipelagos_paleo_area, archipelago_name %in% archipelago_names)

a <- pmatch(
  archipelagos_paleo_area$archipelago_name,
  archipelago_names
)
b <- a[!is.na(a)]
archipelagos23_current <- list()
for (i in seq_along(b)) {
  archipelagos23_current[i] <- archipelagos41[b[i]]
}

archipelagos23_paleo <- archipelagos23_current
for (i in seq_along(archipelagos23)) {
  archipelagos23_paleo[[i]][[1]]$area <-
    archipelagos_paleo_area$ka16_lambeck[i]
}

archipelagos23_names <- c()
for (i in seq_along(archipelagos23)) {
  archipelagos23_names[i] <- archipelagos23_paleo[[i]][[1]]$name
}

usethis::use_data(archipelagos23_paleo, overwrite = TRUE)
usethis::use_data(archipelagos23_current, overwrite = TRUE)
