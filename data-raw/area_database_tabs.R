## code to prepare `area_database_tabs` dataset goes here

path <- system.file(
  "extdata",
  "area_per_archipelago_tabs_2026.csv",
  package = "islandpaleoarea",
  mustWork = TRUE
)

area_database_tabs <- read.csv(path)

usethis::use_data(area_database_tabs, overwrite = TRUE)
