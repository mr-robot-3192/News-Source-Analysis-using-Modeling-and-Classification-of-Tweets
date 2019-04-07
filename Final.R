####################################################################################
##########News Source Analysis Using Modeling and Classification of Tweets##########

#Establishing connection with Twitter API.
source('AuthandHandshake.R')
AuthandHandshake.fun()

#Enter the Keyword.
Tags <- "Syria"

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

#Calculate Tweet Credibility.
source('ModelA.R')
modelAfxn.fun()
modelAT = read.csv("modelAT.csv")

#Calculate Tweeter Credibility.
source('ModelB.R')
modelBfxn.fun()
modelBT = read.csv("modelBT.csv")

#Calculate Final Credibility.
modelF <- tweet_df[,c(30,1)]
modelF$Tweeter_Credibility <- modelBT[,c(9)]
modelF$Tweet_Credibility <- modelAT[,c(4)]
source('FinalCred.R')
credibility.fxn()
modelF = read.csv("Final.csv")
modelF <- modelF[,-1]
