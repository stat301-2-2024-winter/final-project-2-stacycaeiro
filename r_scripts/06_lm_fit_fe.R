# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Fit linear model to feature engineering recipe

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
lm_spec <- linear_reg() %>% 
  set_engine("lm")

# model workflow ----
lm_workflow_fe <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(fe_recipe)

# model fit ----
lm_fit_fe <- lm_workflow_fe |> 
  fit_resamples(
    resamples = articles_fold, 
    control = control_resamples(save_workflow = TRUE)
  )

save(lm_fit_fe, file = here("results/lm_fit_fe.rda"))