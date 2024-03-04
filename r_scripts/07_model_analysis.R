# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Model analysis

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts ----
tidymodels_prefer()

# set seed ----
set.seed(3012)

# load files ----
load(here("results/null_fit.rda"))
load(here("results/lm_fit.rda"))
load(here("results/tuned_rf_basic.rda"))
load(here("results/tuned_bt_basic.rda"))
load(here("results/tuned_knn_basic.rda"))
load(here("results/tuned_en_basic.rda"))

load(here("results/lm_fit_fe.rda"))
load(here("results/null_fit_fe.rda"))
load(here("results/tuned_bt_fe.rda"))
load(here("results/tuned_en_fe.rda"))
load(here("results/tuned_knn_fe.rda"))

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)

doMC::registerDoMC(cores = num_cores)

# null fit model analysis ----
null_results <- null_fit |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  mutate(model = "Null")

save(null_results, file = "results/null_results.rda")

# linear fit model analysis ----
lm_results <- lm_fit |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  mutate(model = "Linear")

save(lm_results, file = "results/lm_results.rda")

# en analysis ----
en_results <- tuned_en_basic |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  mutate(model = "ElasticNet")

en_results

# kitchen sink model analysis ----
basic_model_results <- as_workflow_set(
  baseline_null = null_fit, 
  linear = lm_fit,
  elastic_net = tuned_en_basic,
  random_forest = tuned_rf_basic,
  k_nearest_neighbors = tuned_knn_basic,
  boosted_tree = tuned_bt_basic
)

basic_model_results 

basic_model_results_tibble <- basic_model_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id) |>
  arrange(mean) |>
  select(`Model Type` = wflow_id,
         `RMSE` = mean)

basic_model_results_tibble

save(basic_model_results_tibble, file = here("results/basic_results.rda"))

# feature engineering model analysis ----
fe_model_results <- as_workflow_set(
  baseline_null = null_fit_fe, 
  linear = lm_fit_fe,
  elastic_net = tuned_en_fe,
  k_nearest_neighbors = tuned_knn_fe,
  boosted_tree = tuned_bt_fe
)

fe_model_results_tibble <- fe_model_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id) |>
  arrange(mean) |>
  select(`Model Type` = wflow_id,
         `RMSE` = mean)

fe_model_results_tibble  


