#' DAISIE datalist object including bird phylogenetic data and
#' physical data for 23 archipelagos
#' @format A datalist containing data on 23 of the 41 archipelagos studied in
#' Valente et al 2020 (Main Dataset D1). Contains colonisation and branching
#' times for bird species in each of the archipelagos. It also contains
#' information on archipelago name, area, age and distance from the nearest
#' mainland. Unlike the dataset used in the Valente et al 2020 study, the area
#' of each archipelago here refers to the estimated archipelago area 16kya
#' obtained from the PIAC database (Norder et al 2017).
#' @description A datalist with 23 items representing the 23 archipelagos.
#' Each archipelago can be called separately using `archipelagos23[[x]]` with
#' x being a number between 1 and 23 Using `archipelagos23[[x]][[1]]` will show
#' just the top part of the archipelago item where the archipelago name and
#' physical features are displayed. The structure of each of the archipelagos is
#' the same as regular DAISIE datalist generated using
#' `DAISIE::DAISIE_dataprep()`.
#' @source
#' Norder, Sietze Johannes; Baumgartner, John B; Borges, Paulo A V; Hengl,
#' Tomislav; Kissling, W Daniel; van Loon, E Emiel; Rijsdijk, Kenneth F (2017):
#' Paleo Islands and Archipelago Configuration (PIAC) database. PANGAEA,
#' https://doi.org/10.1594/PANGAEA.880585, Supplement to: Norder, SJ et al.
#' (2018): A global spatially explicit database of changes in island palaeo-area
#' and archipelago configuration during the late Quaternary. Global Ecology and
#' Biogeography, \url{https://doi.org/10.1111/geb.1271}
#'
#' Valente, L., Phillimore, A.B., Melo, M. et al. A simple dynamic model
#' explains the diversity of island birds worldwide. Nature 579, 92–96 (2020).
#' \url{https://doi.org/10.1038/s41586-020-2022-5}
"archipelagos23"
