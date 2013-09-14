################# Cross validation training ##########################

# Framework for train a model using n-fold cross-validation
# Requires |trainingTable| to contain the data available
# |result| is the variable to predict

library(randomForest)
library(adabag)
library(nnet)

TrainCrossValidation <- function(numberKFolds = 5, trainingTable, targetVariable = 'result'){
  # Trains with the model specified in 'Model Training' of the function definition.
  # The prediction is evaluated using k-Fold Cross Validation
  #
  # Args:
  #   numberKFolds: number of partitions to the cross validation
  #   trainingTable: join table of classification.csv and match.csv
  #   targetVariable: variable to predict
  #
  # Returns:
  #   It outputs the accuracy of each try per model

  id = sample(1:numberKFolds,nrow(trainingTable),replace=TRUE)
  listTablon = split(trainingTable,id) # gives you a list with the 5 matrices

  for(indexTest in 1:numberKFolds){
      
    tablonTrain = data.frame()
    for(indexTrain in 1:numberKFolds)
      if(indexTrain!= indexTest)
        tablonTrain = rbind(tablonTrain, listTablon[[indexTrain]])
    
    tablonTest = listTablon[[indexTest]]
    ones = rep(1, length(tablonTrain$result))
    ################## Model Training ################## 
    model.trained = randomForest(as.factor(result) ~ . - result1 -barmad1 - barmad2 - result2 -team1 - team2 -season, data=tablonTrain, na.action=na.omit)
    #model.trained = boosting(as.factor(result) ~ . - result1 -barmad1 - barmad2 - result2 -team1 - team2 -season, data=tablonTrain)
    
    
    ################## Print Results ################## 
    accuracy = tablonTest$result == predict(model.trained, tablonTest)
    print(paste('accuracy:',sum(na.omit(accuracy))/length(na.omit(accuracy))))
    
  }

}
