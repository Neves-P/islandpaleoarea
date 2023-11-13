## code to prepare `results_paleo_minus_outliers` dataset goes here

results_paleo_minus_outliers <- read_results("C:/Users/pedro/Desktop/archipelagos41_paleo/")

usethis::use_data(results_paleo_minus_outliers, overwrite = TRUE) # done 12/11/23

