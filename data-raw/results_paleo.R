## code to prepare `results_paleo` dataset goes here
path <- choose.dir()
results_paleo <- read_results("G:/My Drive/PhD/Projects/paleoarea/results/archipelagos41_paleo")

usethis::use_data(results_paleo, overwrite = TRUE) # dome 14/11/22 8:51

