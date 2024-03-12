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
load(here("results/null_fit_basic.rda"))
load(here("results/lm_fit_basic.rda"))
load(here("results/tuned_rf_basic.rda"))
load(here("results/tuned_bt_basic.rda"))
load(here("results/tuned_knn_basic.rda"))
load(here("results/tuned_en_basic.rda"))

load(here("results/lm_fit_fe.rda"))
load(here("results/null_fit_fe.rda"))
load(here("results/tuned_bt_fe.rda"))
load(here("results/tuned_en_fe.rda"))
load(here("results/tuned_knn_fe.rda"))
load(here("results/tuned_rf_fe.rda"))

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)
doMC::registerDoMC(cores = num_cores)

# best rmse per model ----
bt_basic_rmse <- show_best(tuned_bt_basic, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "Boosted Tree (Basic)")

null_basic_rmse <- show_best(null_fit, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "Null (Basic)")

lm_basic_rmse <- show_best(lm_fit, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "Linear (Basic)")

rf_basic_rmse <- show_best(tuned_rf_basic, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "Random Forest (Basic)")

knn_basic_rmse <- show_best(tuned_knn_basic, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "K-Nearest Neighbors (Basic)")

en_basic_rmse <- show_best(tuned_en_basic, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "Elastic Net (Basic)")

bt_rmse <- show_best(tuned_bt_fe, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "Boosted Tree")

null_rmse <- show_best(null_fit_fe, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "Null")

lm_rmse <- show_best(lm_fit_fe, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "Linear")

rf_rmse <- show_best(tuned_rf_fe, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "Random Forest")

knn_rmse <- show_best(tuned_knn_fe, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "K-Nearest Neighbors")

en_rmse <- show_best(tuned_en_fe, metric = "rmse") |>
  slice_head(n = 1) |>
  mutate(Model = "Elastic Net")

# rmse tibble
rmse_tibble <- bind_rows(
  null_basic_rmse, 
  null_rmse,
  lm_basic_rmse,
  lm_rmse,
  en_basic_rmse,
  en_rmse,
  rf_basic_rmse,
  rf_rmse,
  en_basic_rmse,
  en_rmse,
  knn_basic_rmse,
  knn_rmse,
  bt_basic_rmse,
  bt_rmse
) |>
  arrange(mean)

save(rmse_tibble, file = here("results/rmse_tibble.rda"))
