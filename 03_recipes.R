# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Creating recipes

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

# Null Model ----
null_recipe <- recipe(shares_log ~., data = articles_train)|>
  step_rm(url, timedelta) |>
  step_zv(all_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_impute_linear(all_numeric_predictors()) |>
  step_normalize(all_numeric_predictors())

#prep(null_recipe) |>
#  bake(new_data = NULL)
  
