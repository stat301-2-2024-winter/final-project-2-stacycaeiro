# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Null and [] model analysis

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
load(here("results/articles_fold.rda"))
load(here("results/null_recipe.rda"))
load(here("results/null_fit.rda"))

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)

doMC::registerDoMC(cores = num_cores)

# null fit model analysis ----
null_results <- null_fit |>
  collect_metrics() |>
  filter(.metric == "rmse")

save(null_results, file = "results/null_results.rda")
  