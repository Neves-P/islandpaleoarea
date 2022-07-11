#' Title
#'
#' @param results_path
#'
#' @return
#' @export
#'
#' @examples
read_data <- function(results_path = "results") {
  results_files <- list.files(results_path, pattern = "*.rds", full.names = TRUE)
  out <- data.frame(
    age = numeric(),
    model = numeric(),
    seed = numeric(),
    lambra_c0 = numeric(),
    y = numeric(),
    mu_0 = numeric(),
    x = numeric(),
    K_0 = numeric(),
    z = numeric(),
    gamma_0 = numeric(),
    alpha = numeric(),
    lambda_a0 = numeric(),
    beta = numeric(),
    loglik = numeric(),
    df = numeric(),
    conv = numeric()
  )
  for (i in seq_along(results_files)) {
    input <- readRDS(results_files[i])
    split_name <- strsplit(results_files[i], "_")[[1]]
    model <- as.numeric(split_name[4])
    age <- as.numeric(split_name[5])
    seed <- grep(x = split_name[6], pattern = "*.")
    out <- rbind(out, cbind(model, age, seed, input))
  }
}
