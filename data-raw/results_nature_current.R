## code to prepare `results_nature_current` dataset goes here
path <- "G:\\My Drive\\PhD\\Projects\\paleoarea\\results\\archipelagos41\\"
results_nature_current <- read_results(path)

usethis::use_data(results_nature_current, overwrite = TRUE)
