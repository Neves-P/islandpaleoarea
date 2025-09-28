## code to prepare `archipelagos41_paleo_tabs` dataset goes here


if (!requireNamespace("dplyr", quietly = TRUE)) {
  stop("This script requires 'dplyr', please install it.")
}
if (!requireNamespace("DAISIEutils", quietly = TRUE)) {
  stop("This script requires 'DAISIEutils', please install it from the
       tece-lab/DAISIEutils GitHub repo.")
}
if (!requireNamespace("testit", quietly = TRUE)) {
  stop("This script requires 'testit', please install it.")
}

data(archipelagos41, package = "DAISIE")
data(area_database_tabs, package = "islandpaleoarea")
# Get names and assign them as attributes to list
archipelagos <- c()
for (i in seq_along(archipelagos41)) {
  archipelagos[i] <- archipelagos41[[i]][[1]]$name
}
names(archipelagos41) <- archipelagos

# Match island names between Nature paper and database
area_database_tabs$archipelago[
  which(area_database_tabs$archipelago == "Cocos_Costa_Rica")
] <- "Cocos"
testit::assert(
  all(area_database_tabs$archipelago %in% archipelagos)
)

# Add another level to list, each one a time slice in the past
n_time_slices <- length(
  unique(area_database_tabs$year_before_after_present)
)
age_slices <- sort(unique(
  area_database_tabs$year_before_after_present
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
      area_database_tabs,
      archipelago == archipelagos41[[j]][[1]]$name,
      year_before_after_present == age_slices[i]
    ) |> dplyr::select(archipelago, area_km)
    archipelagos41_paleo[[i]][[j]][[1]]$area <- area_slice$area_km
    testit::assert(
      archipelagos41_paleo[[i]][[j]][[1]]$name == area_slice$archipelago
    )
  }
}

usethis::use_data(archipelagos41_paleo, overwrite = TRUE)
