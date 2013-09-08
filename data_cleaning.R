TransformToNumbers <- function(days){
  # transforms an array of days from 'Jornada n' to n as number
  days = data.frame(lapply(days, as.character), stringsAsFactors=FALSE) 
  days = data.frame(lapply(days, function(x) as.numeric(substring(x,9,nchar(x)))))
  return(days)
}


CleanClassification <- function(classificationDF){
  
  classificationDF['day'] = TransformToNumbers(classificationDF['day'])
  
  # classification needs to be substracted a day in order to be joined
  classificationDF['day'] = classificationDF['day']-1
  
  return(classificationDF)
}

CleanMatchDF <- function(matchDF){
  matchDF['day'] = TransformToNumbers(matchDF['day'])
  
  return(matchDF)
}
