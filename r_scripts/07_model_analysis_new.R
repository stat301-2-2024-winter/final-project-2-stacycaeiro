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

# kitchen sink model analysis ----
show_best(tuned_bt_basic, metric = "rmse") |>
  slice_sample(n = 1)
