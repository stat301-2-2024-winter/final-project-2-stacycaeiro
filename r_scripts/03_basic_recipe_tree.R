# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Tree Recipe

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts ----
tidymodels_prefer()

# set seed ----
set.seed(3012)

# load files ----
load(here("results/articles_split.rda"))

# recipe ----
basic_recipe_tree <- recipe(shares_log ~., 
                            data = articles_train) |>
  step_rm(url, timedelta) |>
  step_zv(all_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_normalize(all_numeric_predictors())

prep(basic_recipe_tree) |>
  bake(new_data = NULL) |>
  glimpse()

save(basic_recipe_tree, file = "recipes/basic_recipe_tree.rda")
