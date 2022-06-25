args <- commandArgs(trailingOnly = TRUE)

library(DAISIE)

array_index <- as.numeric(args[1])
methode <- args[4]
optimmethod <- args[5]
start_time <- args[2]
end_time <- args[3]



a_vals <- read.table("a_vals.txt", header = F)

the_dataset <- a_vals[array_index, 1]
model <- a_vals[array_index, 3]

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
  data_name = data_name,
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

datalist <- archipelagos41_paleo[[the_dataset]]

model_args <- setup_mw_model(model)
initparsopt <- model_args$initparsopt
idparsopt <- model_args$idparsopt
parsfix <- model_args$parsfix
idparsfix <- model_args$idparsfix
res <- model_args$initparsopt
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
to_write <- c(
  array_index,
  the_dataset,
  seed,
  model,
  distance_dep,
  distance_type,
  as.matrix(lik_res),
  initparsopt,
  "\n"
)

file_name <- paste0("results_", array_index, ".txt")
cat(to_write, file = file_name, append = TRUE)
