data(archipelagos41, package = "DAISIE")
archipelagos_paleo_area <- readr::read_csv("inst/extdata/archipelagos_paleo_area.csv")
archipelago_names <- c()

for (i in seq_along(archipelagos41)) {
  archipelago_names[i] <- archipelagos41[[i]][[1]]$name
}
archipelagos_to_use <- list()
a <- pmatch(archipelagos_paleo_area[, 1]$archipelagos_paleo_area, archipelago_names)
b <- a[!is.na(a)]

archipelagos23 <- list()
for (i in seq_along(b)) {
  archipelagos23[i] <- archipelagos41[[b[i]]]
}
