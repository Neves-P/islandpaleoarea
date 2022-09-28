#' Plot model selection area plot
#'
#' @param ordered_results
#' @param best_models
#'
#' @return
#' @export
#'
#' @examples
#' data(ordered_results_paleo)
#' model_sel_plot <- plot_model_sel_time(ordered_results)
plot_model_sel_time <- function(ordered_results,
                                best_models = c(17, 19, 18)) {
  levels(ordered_results$model) <- c(levels(ordered_results$model), "Other\nmodels")
  for (i in seq_along(ordered_results$model)) {
    if (!(ordered_results$model[i] %in% best_models)) {
      ordered_results$model[i] <- factor("Other\nmodels")
    }
  }
  plot_data_frame <- data.frame(
    age = numeric(),
    model = numeric(),
    bic_weights = numeric()
  )
  for (age_slice in unique(ordered_results$age)) {
    lines_to_change <- which(ordered_results$age == age_slice)
    subset_df <- ordered_results[lines_to_change, ]
    good_model_lines <- which(subset_df$model != "Other\nmodels")
    good_weights <- sum(subset_df$bic_weights[good_model_lines])
    bad_model_lines <- which(subset_df$model == "Other\nmodels")
    bad_model_weights <- 1 - good_weights
    testit::assert(bad_model_weights >= 0)
    lines_to_keep <- cbind(
      subset_df[good_model_lines, 1:2],
      subset_df[good_model_lines, "bic_weights"]
    )
    line_to_insert <- data.frame(
      age = age_slice,
      model = factor("Other\nmodels"),
      bic_weights = bad_model_weights
    )
    plot_data_frame <- rbind(plot_data_frame, lines_to_keep, line_to_insert)
    testit::assert(identical(sum(
      plot_data_frame[
        which(plot_data_frame["age"] == age_slice), "bic_weights"
      ]),
      1
    )
    )
  }
  out <- ggplot2::ggplot(plot_data_frame,
                         ggplot2::aes(x = age, y = bic_weights, fill = model)) +
    ggplot2::geom_area() +
    ggplot2::scale_fill_brewer(palette = "Set3") +
    ggplot2::theme_classic() +
    ggplot2::xlab("Age (kyr)") +
    ggplot2::ylab("BIC weight") +
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Model"))
  out
}

