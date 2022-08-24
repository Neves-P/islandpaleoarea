## code to prepare `results_nature_current` dataset goes here
path <- system.file("extdata", package = "islandpaleoarea", "archipelagos41", mustWork = TRUE)
results_nature_current <- read_results(path)

usethis::use_data(results_nature_current, overwrite = TRUE)
