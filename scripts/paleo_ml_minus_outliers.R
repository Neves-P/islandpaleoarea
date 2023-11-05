args <- commandArgs(trailingOnly = TRUE)

library(DAISIE)
library(islandpaleoarea)

array_index <- as.numeric(args[1])
time_slice <- as.numeric(args[2])
methode <- args[3]
optimmethod <- args[4]

model_vec <- sort(rep(17:19, 15))
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
  data_name = paste(data_name, time_slice, sep = "_"),
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

datalist <- archipelagos41_paleo[[time_slice]]
arch_to_remove <- c("Lord_Howe", "Norfolk", "Chagos", "Seychelles_Inner")
datalist <- datalist[which(!names(archipelagos41_paleo[[1]]) %in% arch_to_remove)]
message("Removed archipelagos: ", paste(arch_to_remove, collapse = " "))
message("Kept archipelagos: ", paste(names(datalist), collapse = " "))


model_args <- setup_mw_model(model)
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
