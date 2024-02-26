library(tidyverse)
library(naniar)

articles <- read_csv("data/OnlineNewsPopularity.csv")

glimpse(articles)

news_articles |>
  select(is.numeric)

gg_miss_var(articles)

ggplot(articles, aes(x = shares)) +
  geom_histogram() + 
  xlim(0, 75000) + 
  ylim(0, 17500)

ggplot(articles, aes(x = log(shares))) + 
  geom_histogram(bins = 30) 

articles |>
  select(shares) |>
  summarize(max = max(shares, na.rm = TRUE))

