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
rf_metrics <- metric_set(rmse, rsq, mae)

rf_predict <- articles_test |> 
  bind_cols(predict(rf_fit_final, articles_test)) |> 
  select(shares_log, .pred)

rf_metrics(rf_predict, 
           truth = shares_log, 
           estimate = .pred)

save(rf_metrics, file = here("results/rf_final_metrics.rda"))
