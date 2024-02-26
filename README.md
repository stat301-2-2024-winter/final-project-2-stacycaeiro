## Overview of Project

Final project for STAT 301-2 at Northwestern University. My project is to predict the number of social media shares a Mashable news article will receive. Additionally, I will be using the [Online News Popularity](https://archive.ics.uci.edu/dataset/332/online+news+popularity) from the [UC Irvine Machine Learning Repository](https://archive.ics.uci.edu/).

## What's in this Repo?

### R_Scripts/ 
`01_data_exploration.R`: initial EDA 
`02_data_split.R`: clean, fold, and split dataset 
`03_basic_recipe.R`: basic kitchen sink recipe 
`03_fe_recipe.R`: feature engineering recipe for non-tree models 
`03_tree_recipe.R`: feature engineering recipe for tree models 
`04_bt_fit.R`: boosted tree model tuning and fit 
`04_knn_fit.R`: k-nearest neighbors model tuning and fit 
`04_lasso_fit.R`: lasso model tuning and fit 
`04_rf_fit.R`: random forest model tuning and fit 
`04_null_fit.R`: null model tuning and fit 
`04_lm_fit.R`: linear model tuning and fit 
`05_model_analysis.R`: collect metrics for all 6 models 

### Results/
`articles_fold.rda`: folded data 
`articles_split.rda`: training and testing data split 
`basic_recipe.rda`: basic kitchen sink recipe 
`lm_fit.rda`: linear model fit 
`null_fit.rda`: null model fit 
`lm_results.rda`: linear model metrics results 
`null_results.rda`: null model metrics results 

### Data/
`OnlineNewsPopularity.csv`: raw dataset 

### Memos/ 
`Caeiro_Stacy_progress_memo_1.qmd`: qmd of progress memo 1
`Caeiro_Stacy_progress_memo_2.html`: html of progress memo 1
`Caeiro_Stacy_progress_memo_2.qmd`: qmd of progress memo 2
`Caeiro_Stacy_progress_memo_2.html`: html of progress memo 2

