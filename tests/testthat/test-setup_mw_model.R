test_that("multiplication works", {
  set.seed(1)
  out <- setup_mw_model(1)
  expected_output <- list(
    initparsopt = c(
      0.5383622396527790,
      0.0,
      0.7442477992735803,
      0.0,
      72.2354686178732663,
      0.0,
      0.0908207789994776,
      0.0,
      0.4033638620749116,
      0.0001000000000000
    ),
    idparsopt = 1:10,
    parsfix = NULL,
    idparsfix = NULL,
    res = 100,
    ddmodel = 11,
    cpus = 6,
    tol = c(1e-04, 1e-05, 1e-07),
    distance_type = "continent",
    distance_dep = "power"
  )

  expect_equal(out, expected_output)
})
