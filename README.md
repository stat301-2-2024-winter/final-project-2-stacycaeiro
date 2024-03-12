## Overview of Project

Final project for STAT 301-2 at Northwestern University. My project is to predict the number of social media shares a Mashable news article will receive. Additionally, I will be using the [Online News Popularity](https://archive.ics.uci.edu/dataset/332/online+news+popularity) from the [UC Irvine Machine Learning Repository](https://archive.ics.uci.edu/).

## What's in this Repo?

### r_scripts/ 
`01_target_var_exploration`: analysis of target variable shares, initial data skim
`02_data_split.R`: clean, fold, and split dataset 
`03_EDA.R`: exploratory data analysis for determining pre-processing steps
`04_basic_recipe.R`: basic kitchen sink recipe 
`04_basic_recipe.R`: basic kitchen sink recipe for tree models
`04_fe_recipe.R`: feature engineering recipe for non-tree models 
`04_fe_recipe_tree.R`: feature engineering recipe for tree models 
`05_bt_tune_basic.R`: boosted tree model tuning and fit with basic recipe
`05_knn_tune_basic.R`: k-nearest neighbors model tuning and fit with basic recipe
`05_en_tune_basic.R`: elastic net model tuning and fit with basic recipe
`05_rf_tune_basic.R`: random forest model tuning and fit with basic recipe
`05_null_fit_basic.R`: null model tuning and fit with basic recipe
`05_lm_fit_basic.R`: linear model tuning and fit with basic recipe
`06_bt_tune_fe.R`: boosted tree model tuning and fit with feature engineering recipe
`06_knn_tune_fe.R`: k-nearest neighbors model tuning and fit with feature engineering recipe
`06_en_tune_fe.R`: elastic net model tuning and fit with feature engineering recipe
`06_rf_tune_fe.R`: random forest model tuning and fit with feature engineering recipe
`06_null_fit_fe.R`: null model tuning and fit with feature engineering recipe
`06_lm_fit_fe.R`: linear model tuning and fit with feature engineering recipe
`07_model_analysis.R`: collect RMSE and best hyperparameters for all 12 models 
`08_final_model_fit.R`: fit random forest model with best hyperparameters to entire training dataset 
`09_final_model_analysis`: collect metrics on final random forest model and test predictions

### results/
`lm_fit_basic.rda`: lm fit with basic recipe 
`lm_fit_fe.rda`: lm fit with feature engineering recipe
`null_fit_basic.rda`: null fit with basic recipe 
`null_fit_fe.rda`: null fit with feature engineering recipe
`tuned_bt_basic.rda`: tuned boosted tree model with basic recipe
`tuned_bt_fe.rda`: tuned boosted tree model with feature engineering recipe 
`tuned_en_basic.rda`: tuned elastic net model with basic recipe
`tuned_en_fe.rda`: tuned elastic net model with feature engineering recipe 
`tuned_rf_basic.rda`: tuned random forest model with basic recipe
`tuned_rf_fe.rda`: tuned random forest model with feature engineering recipe 
`tuned_knn_basic.rda`: tuned k-nearest neighbors model with basic recipe
`tuned_knn_fe.rda`: tuned k-nearest neighbors model with feature engineering recipe 
`lm_results.rda`: RMSE of linear fit with basic recipe 
`null_results.rda` RMSE of null fit with basic recipe 
`rmse_tibble.rda`: RMSE and best tuning hyperparameters for all 12 models
`rf_fit_final.rda`: final random forest fit with basic recipe and best hyperparameters 
`rf_final_metrics_scaled.rda`: prediction & analysis of final random forest model on original data scale 
`rf_final_metrics.rda`: prediction & analysis of final random forest model on log scale 

### data/
`OnlineNewsPopularity.csv`: raw dataset 

### data_splits/ 
`articles_fold.rda`: folded data, v-fold cross validation with 5 folds 
`articles_split.rda`: split data, 80% training and 20% testing 
`articles_train.rda`: training dataset 
`articles_test.rda`: testing dataset 

### img/ 
`pred_vs_shares_log.png`: scatterplot of predicted shares vs actual shares on log scale 
`pred_vs_shares_scaled.png`: scatterplot of predicted shares vs actual shares on original scale 
`shares_hist.png`: histogram of shares 

### recipes/ 
`basic_recipe_tree.rda`: basic kitchen sink recipe for tree models 
`basic_recipe.rda`: basic kitchen sink recipe for non-tree models 
`fe_recipe_tree.rda`: feature engineering recipe for tree models 
`fe_recipe.rda`: feature engineering recipe for non-tree models

### memos/ 
`Caeiro_Stacy_progress_memo_1.qmd`: qmd of progress memo 1
`Caeiro_Stacy_progress_memo_2.html`: html of progress memo 1
`Caeiro_Stacy_progress_memo_2.qmd`: qmd of progress memo 2
`Caeiro_Stacy_progress_memo_2.html`: html of progress memo 2

