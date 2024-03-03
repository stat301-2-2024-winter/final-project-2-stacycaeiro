# STAT 301-2 Final Project: Predicting Social Media Shares ----
# Exploratory data analysis 

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

# load files ----
load(here("data_splits/articles_train.rda"))

# create subset of training data ----
total_rows <- nrow(articles_train)
subset_size <- round(0.8 * total_rows)
subset_indices <- sample(1:total_rows, size = subset_size, replace = FALSE)
subset_articles <- articles_train[subset_indices, ]

# EDA ----

## explore skew 
ggplot(subset_articles, aes(x = log(n_tokens_content))) +
  geom_histogram()

ggplot(subset_articles, aes(x = log(num_hrefs))) +
  geom_histogram()

ggplot(subset_articles, aes(x = log(num_self_hrefs))) +
  geom_histogram()

ggplot(subset_articles, aes(x = num_imgs)) +
  geom_histogram()

ggplot(subset_articles, aes(x = num_videos)) +
  geom_histogram()
# outcome: step_log() all numeric predictors 

# explore interactions ----
ggplot(subset_articles, aes(x = global_rate_positive_words, 
                            y = avg_positive_polarity)) +
  geom_point() +
  geom_abline()

ggplot(subset_articles, aes(x = rate_positive_words, 
                            y = avg_positive_polarity)) +
  geom_point() +
  geom_abline()

# outcome: ends_with("_positive_words")::ends_with("_positive_polarity)
# ends_with(_"negative_words")::ends_with("_negative_polarity")
  