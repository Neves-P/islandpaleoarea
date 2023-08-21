## code to prepare `arch_coordinates` dataset goes here
path <- system.file("extdata", "arch_coordinates.csv", package = "islandpaleoarea")

arch_coordinates <- readr::read_delim(
  path,
  delim = ";",
  escape_double = FALSE,
  trim_ws = TRUE
)

usethis::use_data(arch_coordinates, overwrite = TRUE)
arch_coordinates[,1 ] <- gsub("_", " ", arch_coordinates[,1 ])
print(xtable::xtable(arch_coordinates), include.rownames = FALSE)

