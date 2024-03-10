# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Best model fit - random forest model with basic recipe 

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts ----
tidymodels_prefer()

# set seed ----
set.seed(3012)

# load files ----
load(here("data_splits/articles_train.rda"))
load(here("recipes/basic_recipe_tree.rda"))

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)
doMC::registerDoMC(cores = num_cores)

# model spec ----
rf_spec <- rand_forest(mode = "regression",
                       trees = 500, #to limit computational time
                       mtry = 9,
                       min_n = 2) |>
  set_engine("ranger")

# workflow ----
rf_workflow_final <- workflow() |>
  add_model(rf_spec) |>
  add_recipe(basic_recipe_tree)

# fit ----
rf_fit_final <- fit(rf_workflow_final, articles_train)

save(rf_fit_final, file = here("results/rf_fit_final.rda"))
