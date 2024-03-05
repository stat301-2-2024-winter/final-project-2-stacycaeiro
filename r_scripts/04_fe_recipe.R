# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Feature engineering recipe

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
fe_recipe <- recipe(shares_log ~., data = articles_train)|>
  step_rm(url, timedelta, shares) |>
  step_nzv(all_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_interact(~ num_hrefs:n_tokens_content) |>
  step_interact(~ num_hrefs:num_imgs) |>
  step_YeoJohnson(all_numeric_predictors()) |>
  step_ns(title_sentiment_polarity, global_sentiment_polarity,
          deg_free = 5) |>
  step_normalize(all_numeric_predictors()) |>
  step_corr(all_predictors())

prep(fe_recipe) |>
  bake(new_data = NULL) |>
  glimpse()

# save ----
save(fe_recipe, file = "recipes/fe_recipe.rda")

