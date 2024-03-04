# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Feature engineering recipe for tree models 

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

# recipe ----
fe_recipe_tree <- recipe(shares_log ~., 
                            data = articles_train) |>
  step_rm(url, timedelta) |>
  step_zv(all_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_normalize(all_numeric_predictors()) |>
  step_ns(deg_free = 5)

prep(fe_recipe_tree) |>
  bake(new_data = NULL) |>
  glimpse()

save(fe_recipe_tree, file = "recipes/fe_recipe_tree.rda")
