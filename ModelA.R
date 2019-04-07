
modelAfxn.fun <- function() {
  
  #Libaries to be declared
  install.packages("caret", dependencies = c("Depends", "Suggests"))
  library(caret)
  install.packages("e1071")
  library(e1071)
  
  #Read the required data from csv
  modelA_P = read.csv("modelA_P.csv")
  modelA = read.csv("modelA.csv")
  str(modelA_P)
  modelA_P <- modelA_P[,-1]
  modelA <- modelA[,-1]
  
  #Get credibility for new Dataset.
  predicted_scores <-
    predict (modelA_T, modelA_P, "prob")
  predicted_class <- predict (modelA_T, modelA_P)
  
  #Record the Credibility and write it into csv.
  modelA$Credibility <- predicted_class
  write.csv(modelA, file = "modelAT.csv")
  
}