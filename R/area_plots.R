data(archipelagos41, package = "DAISIE")
archipelagos41[[1]][[1]]$name

names_41 <- c()
names_23 <- c()

for (i in seq_along(archipelagos41)) {
  names_41[i] <- archipelagos41[[i]][[1]]$name
}

for (i in seq_along(archipelagos23)) {
  names_23[i] <- archipelagos23[[i]][[1]]$name
}

paleo_area_archipelago_indices <- which(names_41 %in% names_23)


areas_41 <- c()
for (i in paleo_area_archipelago_indices) {
  print(i)
  areas_41[i] <- archipelagos41[[i]][[1]]$area
}

areas_41 <- areas_41[!is.na(areas_41)]

areas_23 <- c()
for (i in seq_along(archipelagos23)) {
  areas_23[i] <- archipelagos23[[i]][[1]]$area
}
length(areas_41)
plot(areas_41, areas_23)
plot(log(areas_41), log(areas_23))
