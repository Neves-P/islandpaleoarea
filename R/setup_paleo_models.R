setup_paleo_models <- function(model) {

  ## power models
 if (model == 1) {
    initparsopt <- c(lam_c, y, mu, x, K, z, gam, alpha, lam_a, beta_par)
    idparsopt <- 1:10
    parsfix <- NULL
    idparsfix <- NULL
    res <- 100
    ddmodel <- 11
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ## No beta
  if (model == 2) {
    initparsopt <- c(lam_c, y, mu, x, K, z, gam, alpha, lam_a)
    idparsopt <- 1:9
    parsfix <- 0
    idparsfix <- 10
    res <- 100
    ddmodel <- 11
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ## No beta and z
  if (model == 3) {
    initparsopt <- c(lam_c, y, mu, x, K, gam, alpha, lam_a)
    idparsopt <- c(1, 2, 3, 4, 5, 7, 8, 9)
    parsfix <- c(0, 0)
    idparsfix <- c(6, 10)
    res <- 100
    ddmodel <- 11
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }


  ## No beta, K and z
  if (model == 4) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha, lam_a)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9)
    parsfix <- c(Inf, 0, 0)
    idparsfix <- c(5, 6, 10)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }


  ## No beta, K, z, no lam_a
  if (model == 5) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha)
    idparsopt <- c(1, 2, 3, 4, 7, 8)
    parsfix <- c(Inf, 0, 0, 0)
    idparsfix <- c(5, 6, 9, 10)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }


  ## No beta, K, z, lam_a, y
  if (model == 6) {
    initparsopt <- c(lam_c, mu, x, gam, alpha)
    idparsopt <- c(1, 3, 4, 7, 8)
    parsfix <- c(0, Inf, 0, 0, 0)
    idparsfix <- c(2, 5, 6, 9, 10)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ## No beta, K, z, y
  if (model == 7) {
    initparsopt <- c(lam_c, mu, x, gam, alpha, lam_a)
    idparsopt <- c(1, 3, 4, 7, 8, 9)
    parsfix <- c(0, Inf, 0, 0)
    idparsfix <- c(2, 5, 6, 10)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ## No beta, K, z and alpha
  if (model == 8) {
    initparsopt <- c(lam_c, y, mu, x, gam, lam_a)
    idparsopt <- c(1, 2, 3, 4, 7, 9)
    parsfix <- c(Inf, 0, 0, 0)
    idparsfix <- c(5, 6, 8, 10)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
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
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
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
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }



  ## No beta, K, z, alpha, y
  if (model == 11) {
    initparsopt <- c(lam_c, mu, x, gam, lam_a)
    idparsopt <- c(1, 3, 4, 7, 9)
    parsfix <- c(0, Inf, 0, 0, 0)
    idparsfix <- c(2, 5, 6, 8, 10)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }

  ## No beta, K, z, alpha, x
  if (model == 12) {
    initparsopt <- c(lam_c, y, mu, gam, lam_a)
    idparsopt <- c(1, 2, 3, 7, 9)
    parsfix <- c(0, Inf, 0, 0, 0)
    idparsfix <- c(4, 5, 6, 8, 10)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
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
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
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
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "power"
  }



  ## post hoc power models
  if (model == 15) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha, lam_a, beta_par, d0A)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(Inf, 0)
    idparsfix <- c(5, 6)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 5
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "area_additive_clado"
  }

  if (model == 16) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha, lam_a, beta_par, d0A)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(Inf, 0)
    idparsfix <- c(5, 6)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 5
    parallel <- "local"
    optimmethod <- "subplex"
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
    methode <- "lsodes"
    cpus <- 5
    parallel <- "local"
    optimmethod <- "subplex"
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
    methode <- "lsodes"
    cpus <- 5
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "area_interactive_clado2"
  }


  ## M19 BEST MODEL
  if (model == 19) {
    initparsopt <- c(lam_c, mu, x, gam, alpha, lam_a, beta_par, d0A)
    idparsopt <- c(1, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(0, Inf, 0)
    idparsfix <- c(2, 5, 6)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "area_interactive_clado"
  }




  ##### Post-hoc Sigmoid models

  ## Sigmoidal colonisation
  if (model == 20) {
    initparsopt <- c(lam_c, y, mu, x, K, z, kg, xg, lam_a, beta_par, d0g)
    idparsopt <- 1:11
    parsfix <- NULL
    idparsfix <- NULL
    res <- 100
    ddmodel <- 11
    cpus <- 6
    parallel <- "local"
    methode <- "lsodes"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_col"
  }


  ## Sigmoidal anagenesis
  if (model == 21) {
    initparsopt <- c(lam_c, y, mu, x, K, z, gam, alpha, kf, xf, d0f)
    idparsopt <- 1:11
    parsfix <- NULL
    idparsfix <- NULL
    res <- 100
    ddmodel <- 11
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_ana"
  }

  ## Sigmoidal cladogenesis
  if (model == 22) {
    initparsopt <- c(kf, xf, mu, x, K, z, gam, alpha, lam_a, beta_par, d0f)
    idparsopt <- 1:11
    parsfix <- NULL
    idparsfix <- NULL
    res <- 100
    ddmodel <- 11
    cpus <- 6
    parallel <- "local"
    methode <- "lsodes"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_clado"
  }

  ## Sigmoidal colonisation and anagenesis

  if (model == 23) {
    initparsopt <- c(lam_c, y, mu, x, K, z, kg, xg, kf, xf, d0g, d0f)
    idparsopt <- 1:12
    parsfix <- NULL
    idparsfix <- NULL
    res <- 100
    ddmodel <- 11
    cpus <- 6
    parallel <- "local"
    methode <- "lsodes"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_col_ana"
  }


  ## Sigmoidal colonisation, no K, z, beta
  if (model == 24) {
    initparsopt <- c(lam_c, y, mu, x, kg, xg, lam_a, d0g)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 11)
    parsfix <- c(Inf, 0, 0)
    idparsfix <- c(5, 6, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    parallel <- "local"
    methode <- "lsodes"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_col"
  }


  ## Sigmoidal anagenesis, no K, z
  if (model == 25) {
    initparsopt <- c(lam_c, y, mu, x, gam, alpha, kf, xf, d0f)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(Inf, 0)
    idparsfix <- c(5, 6)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_ana"
  }

  ## Sigmoidal cladogenesis, no K, z, beta
  if (model == 26) {
    initparsopt <- c(kf, xf, mu, x, gam, alpha, lam_a, d0f)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 11)
    parsfix <- c(Inf, 0, 0)
    idparsfix <- c(5, 6, 10)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    parallel <- "local"
    methode <- "lsodes"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_clado"
  }


  ## Sigmoidal colonisation and anagenesis, no K, z
  if (model == 27) {
    initparsopt <- c(lam_c, y, mu, x, kg, xg, kf, xf, d0g, d0f)
    idparsopt <- c(1, 2, 3, 4, 7, 8, 9, 10, 11, 12)
    parsfix <- c(Inf, 0)
    idparsfix <- c(5, 6)
    res <- 100
    ddmodel <- 0
    cpus <- 6
    parallel <- "local"
    methode <- "lsodes"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_col_ana"
  }


  ## Sigmoidal anagenesis, no K, z, y
  if (model == 28) {
    initparsopt <- c(lam_c, mu, x, gam, alpha, kf, xf, d0f)
    idparsopt <- c(1, 3, 4, 7, 8, 9, 10, 11)
    parsfix <- c(0, Inf, 0)
    idparsfix <- c(2, 5, 6)
    res <- 100
    ddmodel <- 0
    methode <- "lsodes"
    cpus <- 6
    parallel <- "local"
    optimmethod <- "subplex"
    tol <- c(1E-4, 1E-5, 1E-7)
    distance_type <- distance_type
    distance_dep <- "sigmoidal_ana"
  }
}
