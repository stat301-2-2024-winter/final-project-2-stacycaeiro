# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Fit elastic net with kitchen sink model 

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
load(here("recipes/basic_recipe.rda"))

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
en_workflow_basic <- workflow() |>
  add_model(en_spec) |>
  add_recipe(basic_recipe)

# tune ----
tuned_en_basic <- tune_grid(en_workflow_basic, 
                             articles_fold,
                             grid = en_grid,
                             control = control_grid(save_workflow = TRUE))

# save ----
save(tuned_en_basic, file = here("results/tuned_en_basic.rda"))
