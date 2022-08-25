data("ordered_results_paleo")
View(ordered_results_paleo)

m_19 <- ordered_results_paleo |> dplyr::filter(model == 19)
m_19 <- cbind(m_19, total_area = total_area[m_19$age])

plot_res_area(m_19)

m_17 <- ordered_results_paleo |> dplyr::filter(model == 17)
m_17 <- cbind(m_17, total_area = total_area[m_17$age])

plot_res_area(m_17)

m_18 <- ordered_results_paleo |> dplyr::filter(model == 18)
m_18 <- cbind(m_18, total_area = total_area[m_18$age])

plot_res_area(m_18)
