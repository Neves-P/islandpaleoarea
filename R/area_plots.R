
archipelagos_paleo_area_no_duplicates <- readr::read_csv(
  "data-raw/archipelagos_paleo_area_no_duplicates.csv"
)

plot(
  archipelagos_paleo_area_no_duplicates$ka16_lambeck,
  archipelagos_paleo_area_no_duplicates$k0_PIAC,
  xlab = "16kya area Lambeck km^2",
  ylab = "Current area PIAC km^2",
  main = "Areas of 23 archipelagos"
)
abline(a = 0, b = 1, col = "red")
plot(
  archipelagos_paleo_area_no_duplicates$ka16_lambeck,
  archipelagos_paleo_area_no_duplicates$k0_nature,
  xlab = "16kya area Lambeck km^2",
  ylab = "Current area Nature paper km^2",
  main = "Areas of 23 archipelagos"
)
abline(a = 0, b = 1, col = "red")
plot(
  archipelagos_paleo_area_no_duplicates$ka16_lambeck,
  archipelagos_paleo_area_no_duplicates$ka16_cutler,
  xlab = "16kya area Lambeck km^2",
  ylab = "16kya area Cutler km^2",
  main = "Areas of 23 archipelagos"
)
abline(a = 0, b = 1, col = "red")
plot(
  archipelagos_paleo_area_no_duplicates$k0_PIAC,
  archipelagos_paleo_area_no_duplicates$k0_nature,
  xlab = "Current area PIAC km^2",
  ylab = "Current area Nature paper km^2",
  main = "Areas of 23 archipelagos"
)
abline(a = 0, b = 1, col = "red")


# Remove Seychelles

archipelagos_sans_seyschelles <- archipelagos_paleo_area_no_duplicates[-9, ]


plot(
  archipelagos_sans_seyschelles$ka16_lambeck,
  archipelagos_sans_seyschelles$k0_PIAC,
  xlab = "16kya area Lambeck km^2",
  ylab = "Current area PIAC km^2",
  main = "Areas of 22 archipelagos - no Seyschelles"
)
abline(a = 0, b = 1, col = "red")
plot(
  archipelagos_sans_seyschelles$ka16_lambeck,
  archipelagos_sans_seyschelles$k0_nature,
  xlab = "16kya area Lambeck km^2",
  ylab = "Current area Nature paper km^2",
  main = "Areas of 22 archipelagos - no Seyschelles"
)
abline(a = 0, b = 1, col = "red")
plot(
  archipelagos_sans_seyschelles$ka16_lambeck,
  archipelagos_sans_seyschelles$ka16_cutler,
  xlab = "16kya area Lambeck km^2",
  ylab = "16kya area Cutler km^2",
  main = "Areas of 22 archipelagos - no Seyschelles"
)
abline(a = 0, b = 1, col = "red")
plot(
  archipelagos_sans_seyschelles$k0_PIAC,
  archipelagos_sans_seyschelles$k0_nature,
  xlab = "Current area PIAC km^2",
  ylab = "Current area Nature paper km^2",
  main = "Areas of 22 archipelagos - no Seyschelles"
)
abline(a = 0, b = 1, col = "red")

