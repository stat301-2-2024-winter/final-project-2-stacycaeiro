# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Fit linear model to kitchen sink recipe

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
lm_spec <- linear_reg() %>% 
  set_engine("lm")

# model workflow ----
lm_workflow <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(basic_recipe)

# model fit ----
lm_fit <- lm_workflow |> 
  fit_resamples(
    resamples = articles_fold, 
    control = control_resamples(save_workflow = TRUE)
  )

save(lm_fit, file = "results/lm_fit.rda")
