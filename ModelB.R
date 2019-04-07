
modelBfxn.fun <- function() {
  
  #Libaries to be declared
  install.packages("caret", dependencies = c("Depends", "Suggests"))
  library(caret)
  install.packages("e1071")
  library(e1071)
  
  #Read the required data from csv
  modelB_P = read.csv("modelB_P.csv")
  modelB = read.csv("modelB.csv")
  str(modelB_P)
  modelB_P <- modelB_P[,-1]
  modelB <- modelB[,-1]
  
  #Get credibility for new Dataset.
  predicted_scores <-
    predict (modelB_T, modelB_P, "prob")
  predicted_class <- predict (modelB_T, modelB_P)
  
  #Record the Credibility and write it into csv.
  modelB$Credibility <- predicted_class
  write.csv(modelB, file = "modelBT.csv")
  
}