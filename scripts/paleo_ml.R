args <- commandArgs(trailingOnly = TRUE)

library(DAISIE)
library(islandpaleoarea)

array_index <- as.numeric(args[1])
time_slice <- as.numeric(args[2])
methode <- args[3]
optimmethod <- args[4]

model_vec <- sort(rep(1:28, 15))
model <- model_vec[array_index]
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
  data_name = paste(data_name, model, time_slice, sep = "_"),
  array_index = array_index,
  model = model,
  seed = seed,
  methode = methode,
  optimmethod = optimmethod
)

output_folder_path <- DAISIEutils::create_output_folder(
  data_name = data_name,
  results_dir = NULL
)

# Find previous timeslice results
prev_time_slice <- time_slice - 1
if (prev_time_slice > 0) {

  files_to_read <- list.files(
    path = "G:/My Drive/PhD/Projects/paleoarea/results/archipelagos41_paleo",
    pattern = paste0(data_name, "_", model, "_", prev_time_slice, "_"),
    full.names = TRUE
  )

  previous_time_slice_res <- data.frame(
    age = rep(NA, length(files_to_read)),
    model = rep(NA, length(files_to_read)),
    seed = rep(NA, length(files_to_read)),
    loglik = rep(NA, length(files_to_read)),
    lambda_c0 = rep(NA, length(files_to_read)),
    mu_0 = rep(NA, length(files_to_read)),
    K_0 = rep(NA, length(files_to_read)),
    gamma_0 = rep(NA, length(files_to_read)),
    lambda_a0 = rep(NA, length(files_to_read))
  )

}

for (i in seq_along(files_to_read)) {
  input <- readRDS(files_to_read[i])
  split_name <- strsplit(files_to_read[i], "_")[[1]]
  previous_time_slice_res$model[i] <- as.numeric(split_name[4])
  previous_time_slice_res$age[i] <- as.numeric(split_name[5])
  previous_time_slice_res$seed[i] <- as.numeric(sub("*.rds.*", "\\1", split_name[6]))
  previous_time_slice_res$loglik[i] <- input$loglik
  previous_time_slice_res$lambda_c0[i] = input$lambda_c0
  previous_time_slice_res$mu_0[i] = input$mu_0
  previous_time_slice_res$K_0[i] = input$K_0
  previous_time_slice_res$gamma_0[i] = input$gamma_0
  previous_time_slice_res$lambda_a0[i] = input$lambda_a0
}

datalist <- archipelagos41_paleo[[time_slice]]




model_args <- setup_mw_model(model)
# initparsopt <- model_args$initparsopt
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
    array_index,
    ".rds"
  )
)
saveRDS(
  lik_res,
  file = output_path
)
if (!file.exists(output_path)) {
  message("Error writing RDS file.")
}
