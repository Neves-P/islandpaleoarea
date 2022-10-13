## code to prepare `results_paleo` dataset goes here
path <- "G:\\O meu disco\\PhD\\Projects\\paleoarea\\results\\archipelagos41_paleo\\"
results_paleo <- read_results(path)

usethis::use_data(results_paleo, overwrite = TRUE)
