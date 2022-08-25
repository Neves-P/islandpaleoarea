data("results_nature_current")


nature_old_vs_new_data <- dataset_comparison[1:28, -1] - dataset_comparison[29:56, -1]
nature_comparison <- dataset_comparison[1:28, -1] - dataset_comparison[57:84, -1]
new_vs_nature_new <- dataset_comparison[29:56, -1] - dataset_comparison[57:84, -1]


nature_old_vs_new_data <- nature_old_vs_new_data |> tibble::rowid_to_column(var="Model") %>%
  tidyr::gather(key="Parameter", value="Difference", -1)
ggplot2::ggplot(nature_old_vs_new_data, ggplot2::aes(x = Model, y = Parameter, fill = Difference)) +
  ggplot2::geom_tile()

nature_comparison <- nature_comparison |> tibble::rowid_to_column(var="Model") %>%
  tidyr::gather(key = "Parameter", value = "Difference", -1)
ggplot2::ggplot(nature_comparison, ggplot2::aes(x = Model, y = Parameter, fill = Difference)) +
  ggplot2::geom_tile() +
  ggplot2::ggtitle("Nature data with new\nand old DAISIE")

new_vs_nature_new <- new_vs_nature_new |> tibble::rowid_to_column(var="Model") %>%
  tidyr::gather(key = "Parameter", value = "Difference", -1)
ggplot2::ggplot(new_vs_nature_new, ggplot2::aes(x = Model, y = Parameter, fill = Difference)) +
  ggplot2::geom_tile() +
  ggplot2::ggtitle("New data vs new nature")


# Line plots

ggplot2::ggplot()
