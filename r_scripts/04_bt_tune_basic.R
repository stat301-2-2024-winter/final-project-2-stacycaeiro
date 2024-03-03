# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Fit boosted tree model with kitchen sink recipe

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
bt_spec <- boost_tree(mode = "regression",
                     min_n = tune(), # range [2, 40]
                     mtry = tune(), #range [1,72]
                     learn_rate = tune()) |> #range [-10, -1]
  set_engine("xgboost")

# hyperparameter tuning ----
bt_params <- extract_parameter_set_dials(bt_spec) |>
  update(mtry = mtry(range = c(1,50))) #max 50 bc it's 70% of total predictors

bt_grid <- grid_regular(bt_params, levels = 5)

# workflow ----
bt_workflow_basic <- workflow() |>
  add_model(bt_spec) |>
  add_recipe(basic_recipe_tree)

# tune ----
tuned_bt_basic <- tune_grid(bt_workflow_basic, 
                      articles_fold,
                      grid = bt_grid,
                      control = control_grid(save_workflow = TRUE))

save(tuned_bt_basic, file = here("results/tuned_bt_basic.rda"))
