# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Fit k-nearest neighbor model with feature engineering recipe

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts ----
tidymodels_prefer()

# set seed ----
set.seed(3012)

# load files ----
load(here("data_splits/articles_fold.rda"))
load(here("recipes/fe_recipe_tree.rda"))

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)
doMC::registerDoMC(cores = num_cores)

# model spec ----
knn_spec <- nearest_neighbor(mode = "regression",
                             neighbors = tune()) |>
  set_engine("kknn")

# hyperparameter tuning ----
knn_params <- extract_parameter_set_dials(knn_spec)
knn_grid <- grid_regular(knn_params, levels = 5)

# workflow ----
knn_workflow_fe <- workflow() |>
  add_model(knn_spec) |>
  add_recipe(fe_recipe_tree)

# tune ----
tuned_knn_fe <- tune_grid(knn_workflow_fe, 
                             articles_fold,
                             grid = knn_grid,
                             control = control_grid(save_workflow = TRUE))

# save ----
save(tuned_knn_fe, file = here("results/tuned_knn_fe.rda"))