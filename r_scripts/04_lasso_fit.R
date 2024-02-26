# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Fit lasso model

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
load(here("results/basic_recipe.rda"))