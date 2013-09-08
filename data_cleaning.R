
transformToNumbers = function(days){
  # transforms an array of days from 'Jornada n' to n as number
  days = data.frame(lapply(days, as.character), stringsAsFactors=FALSE) 
  days = data.frame(lapply(days, function(x) as.numeric(substring(x,9,nchar(x)))))
  return(days)
}


classification = read.csv("data/classification.csv", header = TRUE, sep=',')
match = read.csv("data/match.csv", header=TRUE, sep=',')
match = match[c('team1', 'team2', 'season','day', 'result1','result2')]

# transform from strings to numbers
match['day'] = transformToNumbers(match['day'])
classification['day'] = transformToNumbers(classification['day'])

# classification needs to be substracted a day in order to be joined
classification['day'] = classification['day']-1

# merge with the classification results
tablon = merge(x=match, y=classification, by.x=c('team1','season','day'), by.y=c('name','season','day'), all.x = TRUE)
tablon = merge(x=tablon, y=classification, by.x=c('team2','season','day'), by.y=c('name','season','day'), all.x = TRUE)

tablon[sample(nrow(tablon),4),]

# put the Quiniela result: 0 tied, 1 local team wins, 2 visiting team
tablon$result = 0
for(i in 1:nrow(tablon)){
  if(tablon[i,'result1']==tablon[i,'result2']) tablon[i,'result'] = 0
  else if(tablon[i,'result1'] > tablon[i,'result2']) tablon[i,'result'] = 1
  else if(tablon[i,'result1'] < tablon[i,'result2']) tablon[i,'result'] = 2
}

# stats about the probability to win
library(randomForest)
#take out missing values
tablon_clean = tablon[complete.cases(tablon),]
model.rf = randomForest(as.factor(result) ~ . - result1 - result2 -team1 - team2 -season, data=tablon, na.action=na.omit)

prediction = predict(model.rf, tablon)
sum(is.na(prediction))
length(prediction)

accuracy = tablon$result==predict(model.rf, tablon)

plot(model.rf)

################# Cross validation training ##########################

id = sample(1:5,nrow(tablon),replace=TRUE)
ListTablon = split(tablon,id) # gives you a list with the 5 matrices

for(index_test in 1:5){
  
  index_test = 2
  tablon_train = data.frame()
  for(index_train in 1:5)
    if(index_train!= index_test)
      tablon_train = rbind(tablon_train, ListTablon[[index_train]])
  
  tablon_test = ListTablon[[index_test]]
  
  model.rf = randomForest(as.factor(result) ~ . - result1 - result2 -team1 - team2 -season, data=tablon_train, na.action=na.omit)
  
  accuracy = tablon_test$result == predict(model.rf, tablon_test)
  print(paste('accuracy:',sum(na.omit(accuracy))/length(na.omit(accuracy))))
}

ListTablon[[2]] # gives you the second matrix



