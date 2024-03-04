# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Fit elastic net with feature engineering recipe

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
load(here("recipes/fe_recipe.rda"))

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)
doMC::registerDoMC(cores = num_cores)

# model spec ----
en_spec <- linear_reg(mode = "regression", 
                      penalty = tune(), 
                      mixture = tune()) |>
  set_engine("glmnet")

# hyperparameter tuning ----
en_params <- extract_parameter_set_dials(en_spec)
en_grid <- grid_regular(en_params, levels = 5)

# workflow ----
en_workflow_fe <- workflow() |>
  add_model(en_spec) |>
  add_recipe(fe_recipe)

# tune ----
tuned_en_fe <- tune_grid(en_workflow_fe, 
                            articles_fold,
                            grid = en_grid,
                            control = control_grid(save_workflow = TRUE))

# save ----
save(tuned_en_fe, file = here("results/tuned_en_fe.rda"))
