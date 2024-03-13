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
ggplot(subset_articles, aes(x = n_tokens_content)) +
  geom_histogram()

ggplot(subset_articles, aes(x = log(n_tokens_content))) +
  geom_histogram()

ggplot(subset_articles, aes(x = num_hrefs)) +
  geom_histogram()

ggplot(subset_articles, aes(x = log(num_hrefs))) +
  geom_histogram() 

# yeo-johnson ----
ggplot(subset_articles, aes(x = kw_avg_min)) +
  geom_histogram() +
  xlim(0, 7500) + 
  labs(title = "Frequency of Average Shares of Worst Keyword",
       x = "Average Share of Worst Keyword",
       y = "Count")

ggsave(filename = "img/avg_worst_kw.png")

ggplot(subset_articles, aes(x = kw_avg_avg)) +
  geom_histogram() +
  xlim(0, 20000) +
  labs(title = "Frequency of Average Shares of Average Keyword",
       x = "Average Share of Average Keyword",
       y = "Count")

ggsave(filename = "img/avg_avg_kw.png")

ggplot(subset_articles, aes(x = n_tokens_content)) +
  geom_histogram() +
  xlim(0,5000) +
  labs(title = "Frequency of Number of Words in Content",
       x = "Number of Words in Content",
       y = "Count")

ggsave(filename = "img/num_words_content.png")

ggplot(subset_articles, aes(x = num_hrefs)) +
  geom_histogram() +
  xlim(0, 150) + 
  labs(title = "Frequency of Number of Links",
       x = "Number of Links",
       y = "Count")

ggsave(filename = "img/num_links.png")

ggplot(subset_articles, aes(x = self_reference_avg_sharess)) +
  geom_histogram() +
  xlim(0, 200000) + 
  ylim(0, 7500) +
  labs(title = "Frequency of Average Shares of Referenced Articles",
       x = "Average Shares of Referenced Articles",
       y = "Count")

ggsave(filename = "img/avg_shares_ref.png")

ggplot(subset_articles, aes(x = self_reference_min_shares)) +
  geom_histogram() +
  xlim(0, 250000) + 
  ylim(0, 3000) +
  labs(title = "Frequency of Minimum Shares of Referenced Articles",
       x = "Minimum Shares of Referenced Articles",
       y = "Count")

ggsave(filename = "img/min_shares_ref.png")

ggplot(subset_articles, aes(x = log(kw_avg_min))) +
  geom_histogram()

ggplot(subset_articles, aes(x = self_reference_min_shares)) +
  geom_histogram() 

ggplot(subset_articles, aes(x = log(self_reference_min_shares))) +
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

ggplot(subset_articles, aes(x = title_sentiment_polarity)) +
  geom_histogram() + 
  geom_abline(color = "lightslateblue", size = 1.3) +
  labs(title = "Frequency of Title Sentiment Polarity",
       x = "Title Sentiment Polarity",
       y = "Count")

ggsave(filename = "img/title_sentiment_polarity.png")

ggplot(subset_articles, aes(x = global_sentiment_polarity)) +
  geom_histogram() + 
  geom_abline(color = "lightslateblue", size = 1.3) +
  labs(title = "Frequency of Global Sentiment Polarity",
       x = "Global Sentiment Polarity",
       y = "Count")

ggsave(filename = "img/global_sentiment_polarity.png")

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

# second corr plot ----
articles_corr_2 <- subset_articles |>
  select(n_tokens_title, n_tokens_content, n_non_stop_words, num_hrefs, num_imgs,
         num_videos, rate_positive_words, rate_negative_words, avg_positive_polarity,
         avg_negative_polarity, title_subjectivity, title_sentiment_polarity) |>
  cor()

ggcorrplot::ggcorrplot(articles_corr_2)

ggplot(subset_articles, aes(x = num_hrefs, y = n_tokens_content)) +
  geom_point() + 
  geom_abline(color = "lightslateblue", 
              slope = 10) +
  labs(title = "Relationship Between Number of Links & Number of Words in Content",
       x = "Number of Links",
       y = "Number of Words in Content")

ggsave(filename = "img/links_vs_content.png")

ggplot(subset_articles, aes(x = num_hrefs, y = num_imgs)) +
  geom_point() + 
  geom_abline(color = "lightslateblue") +
  labs(title = "Relationship Between Number of Links and Number of Images",
       x = "Number of Links",
       y = "Number of Images")

ggsave(filename = "img/links_vs_images.png")

  