# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Fit random forest model

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
load(here("recipes/basic_recipe_tree.rda"))

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)
doMC::registerDoMC(cores = num_cores)

# model spec ----
rf_spec <- rand_forest(mode = "regression",
                       trees = 500, #to limit computational time
                       mtry = tune(),
                       min_n = tune()) |>
  set_engine("ranger")

# hyperparameter tuning ----
rf_params <- extract_parameter_set_dials(rf_spec) |>
  update(mtry = mtry(range = c(1,36))) #max 36 bc it's 50% of total predictors

rf_grid <- grid_regular(rf_params, levels = 5)

# workflow ----
rf_workflow_basic <- workflow() |>
  add_model(rf_spec) |>
  add_recipe(basic_recipe_tree)

# tune ----
tuned_rf_basic <- tune_grid(rf_workflow_basic, 
                            articles_fold,
                            grid = rf_grid,
                            control = control_grid(save_workflow = TRUE))

save(tuned_rf_basic, file = here("results/tuned_rf_basic.rda"))