
#Libaries to be declared.
install.packages("caret", dependencies = c("Depends", "Suggests"))
library(caret)
install.packages("e1071")
library(e1071)

#Read the required data from csv
modelB_T <- read.csv("TrainB.csv")
str(modelB_T)
modelB_T <- modelB_T[,-1]

#Inputs to Train the machine.
set.seed(55)
trainingRows <- sample(1:nrow(modelB_T), 0.7 * nrow(modelB_T))
training <- modelB_T[trainingRows,]
test <- modelB_T[-trainingRows,]

modelB_T <-
  train(
    Credibility ~ .,
    training,
    method = "multinom",
    trcontrol = trainControl(
      method = "cv",
      number = 5,
      verboseIter = TRUE
    )
  )

#Stats of the Model
predicted_scores <-
  predict (modelB_T, test, "prob")
predicted_class <- predict (modelB_T, test)
table(predicted_class, test$Credibility)
mean(as.character(predicted_class) != as.character(test$Credibility))
modelB_T
