matchDF = read.csv("data/match.csv", header=TRUE, sep=',')

# select all variables names except team1 and team2
variables = names(matchDF)

# select from MatchDF
selectedVariables1 = c()
selectedVariables2 = c()
for(name in names(matchDF))
  if(length(grep("1", name))){
    selectedVariables1 = c(selectedVariables1, name)
  }else if(length(grep("2", name))){
    selectedVariables2 = c(selectedVariables2, name)
  }

match1 = matchDF[, c(selectedVariables1, "day", "season")]
match1 = matchDF[, selectedVariables1]
match2 = matchDF[, selectedVariables2]

newNames1 = c()
for(name in names(match1))
  newNames1 = c(newNames1, substr(name,1,nchar(name)-1))

newNames2 = c()
for(name in names(match2))
  newNames2 = c(newNames2, substr(name,1,nchar(name)-1))

names(match1) = newNames1
names(match2) = newNames2

#Adding day and season
match1$day = matchDF$day
match1$season = matchDF$season
match2$day = matchDF$day
match2$season = matchDF$season

#Joining together
match = rbind(match1, match2)

############# Accumulated statistics until the day #################
source('data_cleaning.R')
match$day = TransformDayToNumbers(match$day)
match$posesion = TransformPercentageToNumber(match$posesion)

AcumulatedUntilDate <- function (season, day, team){
  aux = match[, match$season==season & match$day <= day & match$team == team]
  aux = sqldf('select sum(*) from aux')
}