## code to prepare `archipelagos41_paleo` dataset goes here

data(archipelagos41, package = "DAISIE")
archipelagos_paleo_area_database <- readr::read_csv(
  "data-raw/area_cutler20220211.csv"
)
# Get names and assign them as attributes to list
archipelago_names <- c()
for (i in seq_along(archipelagos41)) {
  archipelago_names[i] <- archipelagos41[[i]][[1]]$name
}
names(archipelagos41) <- archipelago_names

# Match island names between Nature paper and database
archipelagos_paleo_area_database$archipelago_name[
  which(archipelagos_paleo_area_database$archipelago_name == "Cocos_Costa_Rica")
] <- "Cocos"
testit::assert(
  all(archipelagos_paleo_area_database$archipelago_name %in% archipelago_names)
)

# Add another level to list, each one a time slice in the past
n_time_slices <- length(
  unique(archipelagos_paleo_area_database$year_before_after_present)
)
age_slices <- sort(unique(
  archipelagos_paleo_area_database$year_before_after_present
))
archipelagos41_paleo <- vector(mode = "list", length = n_time_slices)
names(archipelagos41_paleo) <- as.character(age_slices)

# Loop over ages
for (i in seq_along(archipelagos41_paleo)) {
  # Fill list with old archipelagos41 with area to be overwritten
  archipelagos41_paleo[[i]] <- archipelagos41
  # Loop over archipelagos
  for (j in seq_along(archipelagos41)) {
    # Extract area of time slice i for archipelago j
    area_slice <- dplyr::filter(
      archipelagos_paleo_area_database,
      archipelago_name == archipelagos41[[j]][[1]]$name,
      year_before_after_present == age_slices[i]
    ) |>  dplyr::select(archipelago_name, area_km)
    archipelagos41_paleo[[i]][[j]][[1]]$area <- area_slice$area_km
    testit::assert(
      archipelagos41_paleo[[i]][[j]][[1]]$name == area_slice$archipelago_name
    )
  }
}

usethis::use_data(archipelagos41_paleo, overwrite = TRUE)
