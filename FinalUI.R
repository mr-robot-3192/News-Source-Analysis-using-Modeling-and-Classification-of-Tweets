
FinalUI.fun <- function(Tags) {
  
  #Fetch and Parse Tweets on required Hashtag.
  source('FetchandParse.R')
  FetchandParse.fun(Tags)
  
  #Clean the Data and generate required paramters for Tweet Content Credibility Processing.
  source('ModelACode.R')
  cleanAfxn.fun()
  modelA_P = read.csv("modelA_P.csv")
  modelA_P <-
    modelA_P[, c(2, 3, 4, 5, 6, 7, 8, 9)]
  
  #Clean the Data and generate required paramters for Tweeter Credibility Processing.
  source('ModelBCode.R')
  cleanBfxn.fun()
  modelB_P = read.csv("modelB_P.csv")
  modelB_P <- modelB_P[, c(2, 3, 4, 5, 6, 7, 8, 9)]
}