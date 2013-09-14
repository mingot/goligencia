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
match2 = matchDF[, c(selectedVariables2, "day", "season")]

newNames1 = c()
for(name in names(match1))
  if(!(name %in% c("day", "season"))){
    newNames1 = c(newNames1, substr(name,1,nchar(name)-1))
  }else{
    newNames1 = c(newNames1,name)
  }

newNames2 = c()
for(name in names(match2))
  if(!(name %in% c("day", "season"))){
    newNames2 = c(newNames2, substr(name,1,nchar(name)-1))
  }else{
    newNames2 = c(newNames2,name)
  }


names(match1) = newNames1
names(match2) = newNames2

matchGlobal = rbind(match1,match2)

# Format posesion
#matchGlobal['posesion'] = gsub("%","", matchGlobal['posesion'])
m#atchGlobal['posesion'] = gsub(",",".", matchGlobal['posesion'])
