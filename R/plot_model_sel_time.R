#' Plot model selection area plot
#'
#' @inheritParams default_params_doc
#'
#' @return An area plot. Area corresponds to BIC weights of the models defined
#' in the `ordered_results` vector.
#' @export
#'
#' @examples
#' data(ordered_results_paleo)
#' model_sel_plot <- plot_model_sel_time(ordered_results_paleo)
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
    bic_weights = numeric(),
    total_area = numeric()
  )
  total_area <- c()
  for (time_slice in seq_along(archipelagos41_paleo)) {
    area <- c()
    distance <- c()
    for (archipelago in seq_along(archipelagos41_paleo[[time_slice]])) {
      area <- c(area, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$area)
      distance <- c(distance, archipelagos41_paleo[[time_slice]][[archipelago]][[1]]$distance_continent)

    }
    total_area[time_slice] <- sum(area)
  }
  max_total_area <- max(total_area)
  for (age_slice in unique(ordered_results$age)) {
    lines_to_change <- which(ordered_results$age == age_slice)
    subset_df <- cbind(ordered_results[lines_to_change, ])
    good_model_lines <- which(subset_df$model != "Other\nmodels")
    good_weights <- sum(subset_df$bic_weights[good_model_lines])
    bad_model_lines <- which(subset_df$model == "Other\nmodels")
    bad_model_weights <- 1 - good_weights
    testit::assert(bad_model_weights >= 0)
    lines_to_keep <- cbind(
      subset_df[good_model_lines, 1:2],
      subset_df[good_model_lines, "bic_weights"],
      total_area = total_area[age_slice] / max_total_area
    )
    line_to_insert <- data.frame(
      age = age_slice,
      model = factor("Other\nmodels"),
      bic_weights = bad_model_weights,
      total_area = total_area[age_slice] / max_total_area
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
  # Need to rescale this
  out <- ggplot2::ggplot() +
    ggplot2::geom_area(data = plot_data_frame, ggplot2::aes(x = age, y = bic_weights, fill = model)) +
    ggplot2::theme_classic() +
    ggplot2::scale_fill_manual(values = c("#CAB2D6", "#FFFF99", "#A6CEE3", "#FB9A99")) +
    ggplot2::xlab("Age (ka)") +
    ggplot2::ylab("BIC weight") +
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Model")) +
    ggplot2::scale_y_continuous(
      name = "BIC weight",
      sec.axis = ggplot2::sec_axis(~.*max_total_area, name = "Total archipelago area km\U00B2")
    ) +
    ggplot2::geom_line(data = plot_data_frame, ggplot2::aes(x = age, y = total_area))




}

