library(tidyverse)
library(skimr)

# skim data ----
articles <- read_csv("data/OnlineNewsPopularity.csv")

glimpse(articles)

skim(articles)

shares_five_num <- summarize(articles, 
          min = min(shares),
          q1 = quantile(shares, 0.25),
          median = median(shares),
          q3 = quantile(shares, 0.75),
          max = max(shares),
          sd = sd(shares))
         
save(shares_five_num, file = here("results/shares_five_num.rda"))

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

# exploratory data analysis ----

