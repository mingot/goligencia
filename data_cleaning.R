TransformDayToNumbers <- function(days){
  # transforms an array of days from 'Jornada n' to n as number
  days = as.character(days)
  days = unlist(lapply(days, function(x) as.numeric(substring(x,9,nchar(x)))))
  return(days)
}

TransformPercentageToNumber <- function(percentage){
  # transforms array of percetages expressed as strings to numbers
  percentage = matchDF$posesion1
  percentage = as.character(percentage)
  percentage = unlist(lapply(percentage, function(x) as.numeric(substring(gsub(",", ".", x),1,nchar(x)-1))))
  return(percentage)
}

CleanClassification <- function(classificationDF){
  
  classificationDF[,'day'] = TransformDayToNumbers(classificationDF[,'day'])
  
  # classification needs to be substracted a day in order to be joined
  classificationDF['day'] = classificationDF['day']-1
  
  return(classificationDF)
}

CleanMatchDF <- function(matchDF){
  matchDF[,'day'] = TransformDayToNumbers(matchDF[,'day'])
  
  #clean posesion
  
  
  return(matchDF)
}
