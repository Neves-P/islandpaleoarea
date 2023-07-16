args <- commandArgs(trailingOnly = TRUE)

library(DAISIE)
library(islandpaleoarea)

array_index <- as.numeric(args[1])
time_slice <- as.numeric(args[2])
methode <- args[3]
optimmethod <- args[4]

model <- array_index
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
  data_name = paste(data_name, model, time_slice, "prev_time", sep = "_"),
  array_index = "prev_time",
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
    path = output_folder_path,
    pattern = paste0(data_name, "_", model, "_", prev_time_slice, "_"),
    full.names = TRUE
  )
  if (length(files_to_read) <= 0) {
    stop("No files found.")
  }

  previous_time_slice_res <- data.frame(
    age = rep(NA, length(files_to_read)),
    model = rep(NA, length(files_to_read)),
    seed = rep(NA, length(files_to_read)),
    lambda_c0 = rep(NA, length(files_to_read)),
    y = rep(NA, length(files_to_read)),
    mu_0 = rep(NA, length(files_to_read)),
    x = rep(NA, length(files_to_read)),
    K_0 = rep(NA, length(files_to_read)),
    z = rep(NA, length(files_to_read)),
    gamma_0 = rep(NA, length(files_to_read)),
    alpha = rep(NA, length(files_to_read)),
    lambda_a0 = rep(NA, length(files_to_read)),
    beta = rep(NA, length(files_to_read)),
    d_0 = rep(NA, length(files_to_read)),
    d0_col = rep(NA, length(files_to_read)),
    d0_ana = rep(NA, length(files_to_read)),
    loglik = rep(NA, length(files_to_read)),
    df = rep(NA, length(files_to_read))
  )
}

for (i in seq_along(files_to_read)) {
  message("reading file ", files_to_read[i])
  input <- readRDS(files_to_read[i])
  split_name <- strsplit(files_to_read[i], "_")[[1]]
  previous_time_slice_res$model[i] <- as.numeric(split_name[4])
  previous_time_slice_res$age[i] <- as.numeric(split_name[5])
  previous_time_slice_res$seed[i] <- as.numeric(sub("*.rds.*", "\\1", split_name[6]))
  previous_time_slice_res$lambda_c0[i] <- input$lambda_c0
  previous_time_slice_res$y[i] <- input$y
  previous_time_slice_res$mu_0[i] <- input$mu_0
  previous_time_slice_res$x[i] <- input$x
  previous_time_slice_res$K_0[i] <- input$K_0
  previous_time_slice_res$z[i] <- input$z
  previous_time_slice_res$gamma_0[i] <- input$gamma_0
  previous_time_slice_res$alpha[i] <- input$alpha
  previous_time_slice_res$lambda_a0[i] <- input$lambda_a0
  previous_time_slice_res$beta[i] <- input$beta
  previous_time_slice_res$d_0[i] <- ifelse(is.null(input$d_0), NA, input$d_0)
  previous_time_slice_res$d0_col[i] <- ifelse(is.null(input$d0_col), NA, input$d0_col)
  previous_time_slice_res$d0_ana[i] <- ifelse(is.null(input$d0_ana), NA, input$d0_ana)
  previous_time_slice_res$loglik[i] <- input$loglik
  previous_time_slice_res$df[i] <- input$df
  previous_time_slice_res$conv[i] <- input$conv # TODO: Skip if not conv
}

bics <- calc_bic(
  loglik = previous_time_slice_res$loglik,
  df = previous_time_slice_res$df,
  n = 1000
)

if (all(is.na(bics))) {
  stop("Files found, but no valid previous results available.")
}

if (all(previous_time_slice_res$conv != 0)) {
  stop("Files found, nothing converged.")
}

best_previous_time_slice <- previous_time_slice_res[which(bics == sort(bics)[1]), ]

message("Using parameters from preceeding time slice.")
message("Files to read were: ", files_to_read)
message("The current time slice is: ", time_slice)
message("The previous time slice is: ", time_slice - 1)
message("The previous time slice initpars are: ", paste(unlist(best_previous_time_slice[4:16]), collapse = " "))

datalist <- archipelagos41_paleo[[time_slice]]

model_args <- setup_mw_model_fixed_pars(model, best_previous_time_slice)
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
    "_prev_time.rds")
)
saveRDS(
  lik_res,
  file = output_path
)
if (!file.exists(output_path)) {
  message("Error writing RDS file.")
}
