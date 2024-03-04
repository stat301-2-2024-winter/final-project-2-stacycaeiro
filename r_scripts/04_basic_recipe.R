# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Basic Recipe

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

# Kitchen Sink Recipe ----
basic_recipe <- recipe(shares_log ~., data = articles_train)|>
  step_rm(url, timedelta) |>
  step_nzv(all_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_normalize(all_numeric_predictors())

prep(basic_recipe) |>
  bake(new_data = NULL) |>
  glimpse()

# save ----
save(basic_recipe, file = "recipes/basic_recipe.rda")
