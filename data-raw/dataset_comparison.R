## code to prepare `dataset_comparison` dataset goes here

path <- system.file("extdata", "dataset_comparison.csv", package = "islandpaleoarea")
dataset_comparison <- readr::read_csv(path)

usethis::use_data(dataset_comparison, overwrite = TRUE)
