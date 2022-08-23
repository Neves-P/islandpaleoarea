## code to prepare `results_paleo` dataset goes here
path <- system.file("extdata", package = "islandpaleoarea", "archipelagos41_paleo", mustWork = TRUE)
results_paleo <- read_results(path)

usethis::use_data(results_paleo, overwrite = TRUE)
