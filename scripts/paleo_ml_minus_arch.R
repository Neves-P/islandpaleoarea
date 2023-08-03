args <- commandArgs(trailingOnly = TRUE)

library(DAISIE)
library(islandpaleoarea)

array_index <- as.numeric(args[1])
time_slice <- as.numeric(args[2])
methode <- args[3]
optimmethod <- args[4]
arch_to_remove <- as.numeric(args[5])
model_to_run <- array_index
parallel <- "local"

data_name <- data(archipelagos41_paleo)

seed <- as.integer(Sys.time()) %% 10000L * array_index
set.seed(
  seed,
  kind = "Mersenne-Twister",
  normal.kind = "Inversion",
  sample.kind = "Rejection"
)

DAISIEutils::print_metadata(
  data_name = paste(data_name, model_to_run, time_slice, "minus_arch", sep = "_"),
  array_index = paste0("minus_arch_", arch_to_remove),
  model = model_to_run,
  seed = seed,
  methode = methode,
  optimmethod = optimmethod
)

output_folder_path <- DAISIEutils::create_output_folder(
  data_name = data_name,
  results_dir = NULL
)


previous_data <- data("ordered_results_paleo", package = "islandpaleoarea")

prev_time_slice <- time_slice - 1

if (prev_time_slice < 1) {
  model_args <- setup_mw_model(model = model_to_run)
  message("Using randomly sampled starting parameters.")
  message("Archipelago removed: ", names(archipelagos41_paleo[[time_slice]][arch_to_remove]))
  message("The current time slice is: ", time_slice)
  message("The initpars are: ", paste(model_args$initparsopt, collapse = " "))

} else{
  best_previous_time_slice <- dplyr::filter(
    ordered_results_paleo,
    age == prev_time_slice,
    model == model_to_run
  )

  testit::assert(
    "nrow best time slice = 1", identical(nrow(best_previous_time_slice), 1L)
  )

  message("Using parameters from preceeding time slice.")
  message("Archipelago removed: ", names(archipelagos41_paleo[[time_slice]][arch_to_remove]))
  message("The current time slice is: ", time_slice)
  message("The previous time slice is: ", time_slice - 1)
  message("The previous time slice initpars are: ", paste(unlist(best_previous_time_slice[4:16]), collapse = " "))


  model_args <- setup_mw_model_fixed_pars(model_to_run, best_previous_time_slice)
}
initparsopt <- model_args$initparsopt
idparsopt <- model_args$idparsopt
parsfix <- model_args$parsfix
idparsfix <- model_args$idparsfix
res <- model_args$res
ddmodel <- model_args$ddmodel
cpus <- model_args$cpus
tol <- model_args$tol
distance_type <- model_args$distance_type
distance_dep <- model_args$distance_dep



datalist <- archipelagos41_paleo[[time_slice]][-arch_to_remove]

lik_res <- DAISIE::DAISIE_MW_ML(
  datalist = datalist,
  initparsopt = initparsopt,
  idparsopt = idparsopt,
  parsfix = parsfix,
  idparsfix = idparsfix,
  res = res,
  ddmodel = ddmodel,
  methode = methode,
  cpus = cpus,
  parallel = parallel,
  optimmethod = optimmethod,
  tol = tol,
  distance_type = distance_type,
  distance_dep = distance_dep
)

output_path <- file.path(
  output_folder_path,
  paste0(
    data_name,
    "_",
    model,
    "_",
    time_slice,
    "_",
    arch_to_remove,
    "_minus_arch.rds")
)
saveRDS(
  lik_res,
  file = output_path
)
if (!file.exists(output_path)) {
  message("Error writing RDS file.")
}
