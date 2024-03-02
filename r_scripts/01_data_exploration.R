library(tidyverse)
library(skimr)

# skim data ----
articles <- read_csv("data/OnlineNewsPopularity.csv")

glimpse(articles)

skim(articles)

gg_miss_var(articles) # no missing variables

# plot target variable ----

shares_hist <- ggplot(articles, aes(x = shares)) +
  geom_histogram() + 
  xlim(0, 75000) + 
  ylim(0, 17500) +
  labs(title = "Frequency of Social Media Shares",
       subtitle = "Most articles receive <10,000 shares",
       x = "Shares",
       y = "Count")

ggsave(filename = "img/shares_hist.png")

ggplot(articles, aes(x = log(shares))) + 
  geom_histogram(bins = 30) 

articles |>
  select(shares) |>
  summarize(max = max(shares, na.rm = TRUE),
            min = min(shares, na.rm = TRUE))

