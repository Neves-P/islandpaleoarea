## code to prepare `area_database` dataset goes here

path <- system.file(
  "extdata",
  "area_cutler20220211.csv",
  package = "islandpaleoarea",
  mustWork = TRUE
)
area_database <- read.csv(path)

usethis::use_data(area_database, overwrite = TRUE)
