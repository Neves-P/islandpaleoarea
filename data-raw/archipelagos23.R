## code to prepare `archipelagos41_paleo` dataset goes here

data(archipelagos41, package = "DAISIE")
archipelagos_paleo_area <- readr::read_csv(
  "data-raw/area_cutler20220211.csv"
)
archipelago_names <- c()
for (i in seq_along(archipelagos41)) {
  archipelago_names[i] <- archipelagos41[[i]][[1]]$name
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
