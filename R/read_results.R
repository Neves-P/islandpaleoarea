#' Read model fitting results
#'
#' @inheritParams default_params_doc
#'
#' @return A data frame with model parameters, model ID, seed and age in ky.
#' @export
#' @author Pedro Santos Neves
read_results <- function(results_path = "results") {
  results_files <- list.files(results_path, pattern = "*.rds", full.names = TRUE)
  out <- data.frame(
    age = rep(NA, length(results_files)),
    model = rep(NA, length(results_files)),
    seed = rep(NA, length(results_files)),
    lambda_c0 = rep(NA, length(results_files)),
    y = rep(NA, length(results_files)),
    mu_0 = rep(NA, length(results_files)),
    x = rep(NA, length(results_files)),
    K_0 = rep(NA, length(results_files)),
    z = rep(NA, length(results_files)),
    gamma_0 = rep(NA, length(results_files)),
    alpha = rep(NA, length(results_files)),
    lambda_a0 = rep(NA, length(results_files)),
    beta = rep(NA, length(results_files)),
    d_0 = rep(NA, length(results_files)),
    d0_col = rep(NA, length(results_files)),
    d0_ana = rep(NA, length(results_files)),
    loglik = rep(NA, length(results_files)),
    df = rep(NA, length(results_files)),
    conv = rep(NA, length(results_files))
  )
  pb <- utils::txtProgressBar(min = 1, max = length(results_files), style = 3)
  for (i in seq_along(results_files)) {
    input <- readRDS(results_files[i])
    split_name <- strsplit(results_files[i], "_")[[1]]
    if ("paleo" %in% split_name) {
      out$model[i] <- as.numeric(split_name[4])
      out$age[i] <- as.numeric(split_name[5])
      if ("prev" %in% split_name) {
        out$seed[i] <- 0 # 0 meaning prev time, not a seed
      }
        out$seed[i] <- as.numeric(sub("*.rds.*", "\\1", split_name[6])) # normal
                                                                        #seed
    } else {
      out$model[i] <- as.numeric(split_name[2])
      out$age[i] <- 1
      out$seed[i] <- as.numeric(sub("*.rds.*", "\\1", split_name[3]))
    }
    out$lambda_c0[i] <- input$lambda_c0
    out$y[i] <- input$y
    out$mu_0[i] <- input$mu_0
    out$x[i] <- input$x
    out$K_0[i] <- input$K_0
    out$z[i] <- input$z
    out$gamma_0[i] <- input$gamma_0
    out$alpha[i] <- input$alpha
    out$lambda_a0[i] <- input$lambda_a0
    out$beta[i] <- input$beta
    out$d_0[i] <- ifelse(is.null(input$d_0), NA, input$d_0)
    out$d0_col[i] <- ifelse(is.null(input$d0_col), NA, input$d0_col)
    out$d0_ana[i] <- ifelse(is.null(input$d0_ana), NA, input$d0_ana)
    out$loglik[i] <- input$loglik
    out$df[i] <- input$df
    out$conv[i] <- input$conv
    utils::setTxtProgressBar(pb, i)
  }
  out
}
