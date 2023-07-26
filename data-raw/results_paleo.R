## code to prepare `results_paleo` dataset goes here

results_paleo <- read_results("/Users/pedro/Desktop/archpaleoprev_prev/results")

usethis::use_data(results_paleo, overwrite = TRUE) # dome 14/11/22 8:51

