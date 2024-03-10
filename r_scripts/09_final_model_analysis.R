# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Best model analysis - random forest model with basic recipe 

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts ----
tidymodels_prefer()

# set seed ----
set.seed(3012)

# load files ----
load(here("data_splits/articles_test.rda"))
load(here("results/rf_fit_final.rda"))

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)
doMC::registerDoMC(cores = num_cores)

# metrics on shares log ----
final_metrics <- metric_set(rmse, rsq, mae)

rf_predict <- articles_test |> 
  bind_cols(predict(rf_fit_final, articles_test)) |> 
  select(shares_log, .pred)

rf_final_metrics <- final_metrics(rf_predict, 
           truth = shares_log, 
           estimate = .pred)

within_10_pct <- rf_predict |>
  summarize(
    within_10_pct = mean(
      (abs(.pred - shares_log)/shares_log )
      <= 0.10)
  )

within_10_pct

save(rf_final_metrics, within_10_pct,
     file = here("results/rf_final_metrics.rda"))

ggplot(rf_predict, aes(x = shares_log, y = .pred)) +
  geom_point(alpha = 0.5) +
  geom_abline() +
  labs(title = "Predicted Shares vs Actual Shares on Log Scale",
       x = "Actual Shares",
       y = "Predicted Shares") 

ggsave(filename = "img/pred_vs_shares_log.png")

# metrics on original scale ---- 
rf_predict_scaled <- articles_test |>
  bind_cols(predict(rf_fit_final, articles_test)) |>
  mutate(.pred_scaled = exp(.pred)) |>
  select(shares, .pred_scaled)

rf_predict_scaled

rf_final_metrics_scaled <- final_metrics(rf_predict_scaled, 
                               truth = shares, 
                               estimate = .pred_scaled)

rf_final_metrics_scaled

within_10_pct_scaled <- rf_predict_scaled |>
  summarize(
    within_10_pct = mean(
      (abs(.pred_scaled - shares)/shares )
      <= 0.10)
  )

within_10_pct_scaled

save(rf_final_metrics_scaled, within_10_pct_scaled, 
     file = here("results/rf_final_metrics_scaled.rda"))

ggplot(rf_predict_scaled, aes(x = shares, y = .pred_scaled)) +
  geom_point(alpha = 0.5) +
  geom_abline() +
  labs(title = "Predicted Shares vs Actual Shares on Original Scale",
       x = "Actual Shares",
       y = "Predicted Shares") 

ggsave(filename = "img/pred_vs_shares_scaled.png")
