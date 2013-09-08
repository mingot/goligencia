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

match1 = matchDF[, selectedVariables1]
match2 = matchDF[, selectedVariables2]

newNames = c()
for(name in names(match1))
  newNames = c(newNames, substr(name,1,nchar(name)-1)) 

# add possession to the second team

names(match1) = newNames
names(match2) = newNames
