translate_pars_model <- function(lamc_0, y, mu_0, x, K_0, z, gam_timesM, alpha, lama_0, beta) {

  # vector with what model is power, additive, etc

  Archipelago <- archipelago_data$Archipelago
  Area <- archipelago_data$Area
  Distance <- archipelago_data$Distance
  Age <- archipelago_data$Age

  lamc_0 <- pars[1]
  y <- pars[2]
  mu_0 <- pars[3]
  x <- pars[4]
  K_0 <- pars[5]
  z <- pars[6]
  gam_0timesM <- pars[7]
  alpha <- pars[8]
  lama_0 <- pars[9]
  beta <- pars[10]

  if(distance_dep == 'power') {
    lambda_c <- lamc_0 * Area^ y
    mu <- mu_0 * Area^ -x
    K <- K_0 * Area^ z
    gamma <- (gam_0timesM * Distance^ -alpha)/M
    lamda_a <- lama_0 * Distance^ beta

    ## M15 model
    if(cladogenesis_dep == 'additive')
    {

      d0 <- pars[11]
      lambda_c <- lamc_0 * (Area^y) * (Distance^d0)
    }

    ## M16 and M19 models
    if(cladogenesis_dep == 'interactive')
    {

      d0 <- pars[11]
      lambda_c <- lamc_0 * Area^(y + d0 * log(Distance))
    }

    ## M17 model
    if(cladogenesis_dep == 'interactive1')
    {

      d0 <- pars[11]
      lambda_c <- lamc_0 * Area^(y + Distance/d0)
    }

    ## M18 model
    if(cladogenesis_dep == 'interactive2')
    {

      d0 <- pars[11]
      lambda_c <- lamc_0 * Area^(y + 1/(1 + d0/Distance))
    }
  }

  if(distance_dep == 'sigmoidal') {
    check_length_pars(11)
    mu <- mu_0 * Area^ -x
    K <- K_0 * Area^ z

    if(sigmoidal_par == 'colonisation'){
      lambda_c <- lamc_0 * Area ^ y
      lamda_a <- lama_0 * Distance ^ beta

      kg <- pars[7]
      xg <- pars[8]
      d_0 <- pars[11]

      g <- function(d,x,d0,k) {k - k * (d/d0)^x/(1 + (d/d0)^x)}

      gamma <- g(Distance,xg,d_0,kg)/M
    }

    if(sigmoidal_par == 'anagenesis'){
      lambda_c <- lamc_0 * Area^ y
      gamma <- (gam_0timesM * Distance^ -alpha)

      kf <- pars[9]
      xf <- pars[10]
      d0_f <- pars[11]

      f <- function(d,x,d0,k) {k * (d/d0)^x/(1 + (d/d0)^x)}
      lamda_a <- f(Distance,xf,d0_f,kf)
    }

    if(sigmoidal_par == 'cladogenesis'){
      lamda_a <- lama_0 * Distance^ beta
      gamma <- (gam_0timesM * Distance^ -alpha)/M

      kf <- pars[1]
      xf <- pars[2]
      d0_f <- pars[11]

      f <- function(d,x,d0,k) {k * (d/d0)^x/(1 + (d/d0)^x)}
      lambda_c <- f(Distance,xf,d0_f,kf)
    }
  }
}
