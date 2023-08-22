## code to prepare `results_paleo` dataset goes here

results_paleo <- read_results("C:/Users/pedro/Desktop/archipelagos41_paleo/")

usethis::use_data(results_paleo, overwrite = TRUE) # done 22/08/23

