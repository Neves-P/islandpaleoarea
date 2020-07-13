## code to prepare `archipelagos23` dataset goes here

data(archipelagos41, package = "DAISIE")
archipelagos_paleo_area <- readr::read_csv(
  "data-raw/archipelagos_paleo_area_no_duplicates.csv"
)
archipelago_names <- c()

for (i in seq_along(archipelagos41)) {
  archipelago_names[i] <- archipelagos41[[i]][[1]]$name
}

a <- pmatch(
  archipelagos_paleo_area[, 1]$archipelagos_paleo_area,
  archipelago_names
)
b <- a[!is.na(a)]

archipelagos23 <- list()
for (i in seq_along(b)) {
  archipelagos23[i] <- archipelagos41[b[i]]
}

for (i in seq_along(archipelagos23)) {
  archipelagos23[[i]][[1]]$area <-
    archipelagos_paleo_area$ka16_lambeck[i]
}

usethis::use_data(archipelagos23, overwrite = TRUE)
