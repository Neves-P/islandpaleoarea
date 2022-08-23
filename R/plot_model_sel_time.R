#' Plot model selection area plot
#'
#' @param ordered_results
#' @param best_models
#'
#' @return
#' @export
#'
#' @examples
plot_model_sel_time <- function(ordered_results,
                                best_models = c(17, 19, 4, 18)) {
  levels(ordered_results$model) <- c(0, levels(ordered_results$model))
  for (i in seq_along(ordered_results$model)) {
    if (!(ordered_results$model[i] %in% best_models)) {
      ordered_results$model[i] <- factor(0)
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
    good_model_lines <- which(subset_df$model != 0)
    good_weights <- sum(subset_df$bic_weights[good_model_lines])
    bad_model_lines <- which(subset_df$model == 0)
    bad_model_weights <- 1 - good_weights
    testit::assert(bad_model_weights >= 0)
    subset_df
  }


  out <- ggplot2::ggplot(ordered_results,
                         ggplot2::aes(x = age, y = bic_weights, fill = model)) +
    ggplot2::geom_area()
  out
}

