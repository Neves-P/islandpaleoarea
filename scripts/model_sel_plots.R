data("ordered_results_paleo")

model_sel_plots <- plot_model_sel_time(ordered_results = ordered_results_paleo,
                                       best_models = c(17, 18, 16, 15))

save_paper_plot(model_sel_plots, file_name = "model_sel_plots")
