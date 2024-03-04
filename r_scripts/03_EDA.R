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
subset_indices <- sample(1:total_rows, 
                         size = subset_size, 
                         replace = FALSE)
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

ggplot(subset_articles, aes(x = log(rate_positive_words))) +
  geom_histogram()

#yeojohnson()
#transformations for neg numbers

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

ggplot(subset_articles, aes(x = avg_positive_polarity, y = shares)) +
  geom_point() +
  geom_abline() +
  facet_wrap(~is_weekend)

ggplot(subset_articles, aes(x = rate_positive_words, y = shares_log)) +
  geom_point() +
  geom_abline()
        

# outcome: ends_with("_positive_words")::ends_with("_positive_polarity)
# ends_with(_"negative_words")::ends_with("_negative_polarity")

# explore splines ----
ggplot(subset_articles, aes(x = title_subjectivity, y = shares)) +
  geom_point()

ggplot(subset_articles, aes(x = title_sentiment_polarity, y = shares)) +
  geom_point()

ggplot(subset_articles, aes(x = abs_title_subjectivity, y = shares)) +
  geom_point()

ggplot(subset_articles, aes(x = title_subjectivity)) +
  geom_histogram()

# outcome: ns(title_subjectivity, title_sentiment_polarity,
#global_subjectivity, global_sentiment_polarity)  

# corr plot ----
articles_corr <- subset_articles |>
  select(is.numeric) |>
  cor()

ggcorrplot::ggcorrplot(articles_corr)
  
ggplot(subset_articles, aes(x = n_unique_tokens, y = n_non_stop_words)) +
  geom_point()

ggplot(subset_articles, aes(x = num_imgs, y = num_videos)) +
  geom_point() +
  geom_abline()

ggplot(subset_articles, aes(x = n_tokens_title, y = n_tokens_content)) +
  geom_point() +
  geom_abline()

ggplot(subset_articles, aes(x = n_tokens_title, y = n_non_stop_words)) +
  geom_point() +
  geom_abline()


