#' Setup parameters needed for MW version of DAISIE
#'
#' @param model A numeric from 1 to 28, corresponding to the model to be run.
#'
#' @return
#' A list with the necessary parameters for the [DAISIE::DAISIE_MW_ML()] run.
#' @export
#' @author Luis Valente, Pedro Santos Neves
#'
#'
#' @examples
#' model_parameters <- setup_mw_model(model = 1)
translate_mw_params <- function(model) { # nolint: cyclocomp_linter start
  distance_type <- "continent"

  #### New initpars sigmoidal colonisation
  kg <- stats::runif(1, min = 10, max = 70)
  xg <- stats::runif(1, min = 0.1, max = 1)
  d0g <- stats::runif(1, min = 1, max = 600000)

  ####  initpars sigmoidal anagenesis and cladogenesis
  kf <- stats::runif(1, min = 0.01, max = 0.04)
  xf <- stats::runif(1, min = 0.1, max = 0.4)
  d0f <- stats::runif(1, min = 1, max = 600000)

  ####  initpars power interactive_clado1; interactive_clado2
  d0 <- stats::runif(1, min = 0, max = 50000)

  ## for area_additive_clado and area_interactive_clado
  d0_a <- 0


  ### distance_dep key

  # 'power' - M1-M14
  # 'area_additive_clado'  - M15
  # 'area_interactive_clado' - M16 and M19
  # 'area_interactive_clado1' - M17
  # 'area_interactive_clado2' - M18
  # 'sigmoidal_col' - M20, M24
  # 'sigmoidal_ana' - M21, M25, M28
  # 'sigmoidal_clado' - M22, M26
  # 'sigmoidal_col_ana' - M23, M27


  ## power models

  if (model == 1) {
    initparsopt <- c(lam_c, y, mu, x, k, z, gam, alpha, lam_a, beta_par)
    idparsopt <- 1:10
    parsfix <- NULL
    idparsfix <- NULL
    res <- 100
    ddmodel <- 11
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ## No beta
  if (model == 2) {
    initparsopt <- c(lam_c, y, mu, x, k, z, gam, alpha, lam_a)
    idparsopt <- 1:9
    parsfix <- 0
    idparsfix <- 10
    res <- 100
    ddmodel <- 11
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ## No beta and z
  if (model == 3) {
    initparsopt <- c(lam_c, y, mu, x, k, gam, alpha, lam_a)
    idparsopt <- c(1, 2, 3, 4, 5, 7, 8, 9)
    parsfix <- c(0, 0)
    idparsfix <- c(6, 10)
    res <- 100
    ddmodel <- 11
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }


  ## No beta, k and z
  if (model == 4) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha, lam_a)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9)
    parsfix <- c(Inf, 0, 0)
    idparsfix <- c(5, 6, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }


  ## No beta, k, z, no lam_a
  if (model == 5) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha)
    idparsopt <- c(1, 2, 3, 4, 7, 8)
    parsfix <- c(Inf, 0, 0, 0)
    idparsfix <- c(5, 6, 9, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }


  ## No beta, k, z, lam_a, y
  if (model == 6) {
    initparsopt <- c(lam_c, mu, x, gam, alpha)
    idparsopt <- c(1, 3, 4, 7, 8)
    parsfix <- c(0, Inf, 0, 0, 0)
    idparsfix <- c(2, 5, 6, 9, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ## No beta, k, z, y
  if (model == 7) {
    initparsopt <- c(lam_c, mu, x, gam, alpha, lam_a)
    idparsopt <- c(1, 3, 4, 7, 8, 9)
    parsfix <- c(0, Inf, 0, 0)
    idparsfix <- c(2, 5, 6, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ## No beta, k, z and alpha
  if (model == 8) {
    initparsopt <- c(lam_c, y, mu, x, gam, lam_a)
    idparsopt <- c(1, 2, 3, 4, 7, 9)
    parsfix <- c(Inf, 0, 0, 0)
    idparsfix <- c(5, 6, 8, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ##
  if (model == 9) {
    initparsopt <- c(lam_c, mu, x, gam, alpha, lam_a, beta_par)
    idparsopt <- c(1, 3, 4, 7, 8, 9, 10)
    parsfix <- c(0, Inf, 0)
    idparsfix <- c(2, 5, 6)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }


  ##
  if (model == 10) {
    initparsopt <- c(lam_c, mu, x, gam)
    idparsopt <- c(1, 3, 4, 7)
    parsfix <- c(0, Inf, 0, 0, 0, 0)
    idparsfix <- c(2, 5, 6, 8, 9, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }



  ## No beta, k, z, alpha, y
  if (model == 11) {
    initparsopt <- c(lam_c, mu, x, gam, lam_a)
    idparsopt <- c(1, 3, 4, 7, 9)
    parsfix <- c(0, Inf, 0, 0, 0)
    idparsfix <- c(2, 5, 6, 8, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ## No beta, k, z, alpha, x
  if (model == 12) {
    initparsopt <- c(lam_c, y, mu, gam, lam_a)
    idparsopt <- c(1, 2, 3, 7, 9)
    parsfix <- c(0, Inf, 0, 0, 0)
    idparsfix <- c(4, 5, 6, 8, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }



  ##
  if (model == 13) {
    initparsopt <- c(lam_c, mu, x, gam, lam_a, beta_par)
    idparsopt <- c(1, 3, 4, 7, 9, 10)
    parsfix <- c(0, Inf, 0, 0)
    idparsfix <- c(2, 5, 6, 8)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ## Best a priori model M14
  if (model == 14) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha, lam_a, beta_par)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 10)
    parsfix <- c(Inf, 0)
    idparsfix <- c(5, 6)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }



  ## post hoc power models
  if (model == 15) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha, lam_a, beta_par, d0_a)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(Inf, 0)
    idparsfix <- c(5, 6)
    res <- 100
    ddmodel <- 0
    cpus <- 5
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "area_additive_clado"
  }

  if (model == 16) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha, lam_a, beta_par, d0_a)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(Inf, 0)
    idparsfix <- c(5, 6)
    res <- 100
    ddmodel <- 0
    cpus <- 5
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "area_interactive_clado"
  }

  if (model == 17) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha, lam_a, beta_par, d0)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(Inf, 0)
    idparsfix <- c(5, 6)
    res <- 100
    ddmodel <- 0
    cpus <- 5
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "area_interactive_clado1"
  }

  if (model == 18) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha, lam_a, beta_par, d0)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(Inf, 0)
    idparsfix <- c(5, 6)
    res <- 100
    ddmodel <- 0
    cpus <- 5
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "area_interactive_clado2"
  }


  ## M19 BEST MODEL
  if (model == 19) {
    initparsopt <- c(lam_c, mu, x, gam, alpha, lam_a, beta_par, d0_a)
    idparsopt <- c(1, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(0, Inf, 0)
    idparsfix <- c(2, 5, 6)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "area_interactive_clado"
  }




  ##### Post-hoc Sigmoid models

  ## Sigmoidal colonisation
  if (model == 20) {
    initparsopt <- c(lam_c, y, mu, x, k, z, kg, xg, lam_a, beta_par, d0g)
    idparsopt <- 1:11
    parsfix <- NULL
    idparsfix <- NULL
    res <- 100
    ddmodel <- 11
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_col"
  }


  ## Sigmoidal anagenesis
  if (model == 21) {
    initparsopt <- c(lam_c, y, mu, x, k, z, gam, alpha, kf, xf, d0f)
    idparsopt <- 1:11
    parsfix <- NULL
    idparsfix <- NULL
    res <- 100
    ddmodel <- 11
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_ana"
  }

  ## Sigmoidal cladogenesis
  if (model == 22) {
    initparsopt <- c(kf, xf, mu, x, k, z, gam, alpha, lam_a, beta_par, d0f)
    idparsopt <- 1:11
    parsfix <- NULL
    idparsfix <- NULL
    res <- 100
    ddmodel <- 11
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_clado"
  }

  ## Sigmoidal colonisation and anagenesis

  if (model == 23) {
    initparsopt <- c(lam_c, y, mu, x, k, z, kg, xg, kf, xf, d0g, d0f)
    idparsopt <- 1:12
    parsfix <- NULL
    idparsfix <- NULL
    res <- 100
    ddmodel <- 11
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_col_ana"
  }


  ## Sigmoidal colonisation, no k, z, beta
  if (model == 24) {
    initparsopt <- c(lam_c, y, mu, x, kg, xg, lam_a, d0g)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 11)
    parsfix <- c(Inf, 0, 0)
    idparsfix <- c(5, 6, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_col"
  }


  ## Sigmoidal anagenesis, no k, z
  if (model == 25) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha, kf, xf, d0f)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(Inf, 0)
    idparsfix <- c(5, 6)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_ana"
  }

  ## Sigmoidal cladogenesis, no k, z, beta
  if (model == 26) {
    initparsopt <- c(kf, xf, mu, x, gam, alpha, lam_a, d0f)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 11)
    parsfix <- c(Inf, 0, 0)
    idparsfix <- c(5, 6, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_clado"
  }


  ## Sigmoidal colonisation and anagenesis, no k, z
  if (model == 27) {
    initparsopt <- c(lam_c, y, mu, x, kg, xg, kf, xf, d0g, d0f)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 10, 11, 12)
    parsfix <- c(Inf, 0)
    idparsfix <- c(5, 6)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_col_ana"
  }


  ## Sigmoidal anagenesis, no k, z, y
  if (model == 28) {
    initparsopt <- c(lam_c, mu, x, gam, alpha, kf, xf, d0f)
    idparsopt <- c(1, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(0, Inf, 0)
    idparsfix <- c(2, 5, 6)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_ana"
  }

  out <- list(
    initparsopt = initparsopt,
    idparsopt = idparsopt,
    parsfix = parsfix,
    idparsfix = idparsfix,
    res = res,
    ddmodel = ddmodel,
    cpus = cpus,
    tol = tol,
    distance_type = distance_type,
    distance_dep = distance_dep
  )
  out
} # nolint end.
