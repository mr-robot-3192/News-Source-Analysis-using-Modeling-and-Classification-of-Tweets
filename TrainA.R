
#Libaries to be declared.
install.packages("caret", dependencies = c("Depends", "Suggests"))
library(caret)
install.packages("e1071")
library(e1071)

#Read the required data from csv
modelA_T <- read.csv("TrainA.csv")
str(modelA_T)
modelA_T <- modelA_T[, -1]

#Inputs to Train the machine.
set.seed(55)
trainingRows <- sample(1:nrow(modelA_T), 0.7 * nrow(modelA_T))
training <- modelA_T[trainingRows, ]
test <- modelA_T[-trainingRows, ]

modelA_T <-
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
  predict (modelA_T, test, "prob")
predicted_class <- predict (modelA_T, test)
table(predicted_class, test$Credibility)
mean(as.character(predicted_class) != as.character(test$Credibility))
modelA_T
