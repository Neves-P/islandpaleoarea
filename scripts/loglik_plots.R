m_17 <- ordered_results_paleo |> dplyr::filter(model == 17)
m_17 <- cbind(m_17, total_area = total_area[m_17$age])
m_18 <- ordered_results_paleo |> dplyr::filter(model == 18)
m_18 <- cbind(m_18, total_area = total_area[m_18$age])
m_19 <- ordered_results_paleo |> dplyr::filter(model == 19)
m_19 <- cbind(m_19, total_area = total_area[m_19$age])

loglik_plot_17 <- ggplot2::ggplot(m_17) +
  ggplot2::geom_line(ggplot2::aes(age, loglik, colour = "loglik")) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.title = ggplot2::element_blank()) +
  ggplot2::xlab("Time before present") +
  ggplot2::ylab("Loglikelihood")
loglik_plot_18 <- ggplot2::ggplot(m_18) +
  ggplot2::geom_line(ggplot2::aes(age, loglik, colour = "loglik")) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.title = ggplot2::element_blank()) +
  ggplot2::xlab("Time before present") +
  ggplot2::ylab("Loglikelihood")
loglik_plot_19 <- ggplot2::ggplot(m_19) +
  ggplot2::geom_line(ggplot2::aes(age, loglik, colour = "loglik")) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.title = ggplot2::element_blank()) +
  ggplot2::xlab("Time before present") +
  ggplot2::ylab("Loglikelihood")
loglik_plot_17 + loglik_plot_18 + loglik_plot_19 + patchwork::plot_layout(guides = "collect")

