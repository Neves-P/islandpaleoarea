## code to prepare `seychelles_area_time` dataset goes here


seychelles_area_time <- readr::read_csv("data-raw/seychelles_area_time.csv")
seychelles_area_time <- readr::read_csv("data-raw/seychelles_area_time.csv")


seychelles_sans_curiouse <- seychelles_area_time[-2, ]

time_vector <- seq(0, 34)
total_area <- c()
for (i in 3:38) {
  total_area[i - 3] <- sum(unique(seychelles_sans_curiouse[, i]))
}

plot(
  time_vector,
  total_area,
  type = "l",
  main = "Seychelles Archipelago Area Variation Through Time",
  xlab = "Time in the past (kya)",
  ylab = "Archipelago area (km^2)",
  lwd = 3
)
usethis::use_data(seychelles_area, overwrite = TRUE)
