TransformToNumbers <- function(days){
  # transforms an array of days from 'Jornada n' to n as number
  days = data.frame(lapply(days, as.character), stringsAsFactors=FALSE) 
  days = data.frame(lapply(days, function(x) as.numeric(substring(x,9,nchar(x)))))
  return(days)
}


CleanClassification <- function(classificationDF){
  
  # Since 'day' has some mistakes and could be that a match is postponed
  # we take the number of 'partits jugats' as day indicator 
  classificationDF['day'] = classificationDF['pj']
  
  # classification needs to be substracted a day in order to be joined
  classificationDF['day'] = classificationDF['day']-1
  
  # Ensuring correct number of points
  classificationDF['points'] = 3*classificationDF['pg'] + classificationDF['pe']
  
  # Selecting relevant features
  classificationDF = classificationDF[!(names(classificationDF) %in% c('pj'))]
  return(classificationDF)
}

CleanMatchDF <- function(matchDF){
  matchDF['day'] = TransformToNumbers(matchDF['day'])
  
  return(matchDF)
}