# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Fit null model

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

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)

doMC::registerDoMC(cores = num_cores)

# model spec ----
null_spec <- null_model() %>% 
  set_engine("parsnip") %>% 
  set_mode("regression")

null_workflow <- workflow() %>% 
  add_model(null_spec) %>% 
  add_recipe(null_recipe)
