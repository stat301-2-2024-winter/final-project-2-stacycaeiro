# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Splitting data into training and testing set

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts ----
tidymodels_prefer()

# set seed ----
set.seed(3012)

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)

doMC::registerDoMC(cores = num_cores)

# load and clean data ----
articles <- read_csv("data/OnlineNewsPopularity.csv") |>
  mutate(
    # log transform outcome var to fix right-skewedness
    shares_log = log(shares),
    #covert numeric binary vars into factors
    data_channel_is_lifestyle = as.factor(data_channel_is_lifestyle),
    data_channel_is_entertainment = as.factor(data_channel_is_entertainment),
    data_channel_is_bus = as.factor(data_channel_is_bus),
    data_channel_is_socmed = as.factor(data_channel_is_socmed),
    data_channel_is_tech = as.factor(data_channel_is_tech),
    data_channel_is_world = as.factor(data_channel_is_world),
    weekday_is_monday = as.factor(weekday_is_monday),
    weekday_is_tuesday = as.factor(weekday_is_tuesday),
    weekday_is_wednesday = as.factor(weekday_is_wednesday),
    weekday_is_thursday = as.factor(weekday_is_thursday),
    weekday_is_friday = as.factor(weekday_is_friday),
    weekday_is_saturday = as.factor(weekday_is_saturday),
    weekday_is_sunday = as.factor(weekday_is_sunday),
    is_weekend = as.factor(is_weekend)
         )

# split data ----
articles_split <- initial_split(articles, 
                                prop = 0.8, 
                                strata = shares_log)
articles_train <- training(articles_split)
articles_test <- testing(articles_split)

# fold data ----
articles_fold <- vfold_cv(articles_train,
                          v = 5, 
                          repeats = 3, 
                          strata = shares_log)

# save ----
save(articles_split, file = "data_splits/articles_split.rda")
save(articles_train, file = "data_splits/articles_train.rda")
save(articles_test, file = "data_splits/articles_test.rda")
save(articles_fold, file = "data_splits/articles_fold.rda")

