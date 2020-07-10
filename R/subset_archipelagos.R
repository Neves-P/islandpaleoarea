data(archipelagos41, package = "DAISIE")
archipelagos_paleo_area <- readr::read_csv("inst/extdata/archipelagos_paleo_area.csv")
archipelago_names <- c()

for (i in seq_along(archipelagos41)) {
  archipelago_names[i] <- archipelagos41[[i]][[1]]$name
}
archipelagos_to_use <- list()
for (i in seq_along(archipelagos41)) {
  if (!is.na(pmatch(archipelagos_paleo_area[i,1], archipelago_names))) {
    archipelagos_to_use[[i]] <- archipelagos41[[i]]
  }
}

