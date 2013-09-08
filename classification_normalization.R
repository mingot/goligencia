
NormalizeClassification <- function(classificationDF){
  # Normalizes the data from classification.csv per each day
  #
  # Args:
  #   classificationDF: the data frame from classification.csv
  #
  # Returns:
  #   The same table normalized per each day.
  

  library(sqldf)

  originalNames = names(classificationDF)
  selectedNames = names(classificationDF)
  selectedNames = selectedNames[!(selectedNames %in% c('name', 'season', 'day', 'position'))]
  query = ''
  for(name in selectedNames)
    query = paste(query, ', sum(',name,') as ',name,'total', sep="")
  
  query = paste("select season, day", query, " from classificationDF group by day, season", sep="")
  dayValues  = sqldf(query)
  
  classificationDF = merge(x=classificationDF, y=dayValues, all.x=TRUE)
  
  for(name in selectedNames)
    classificationDF[,name] = classificationDF[,name]/classificationDF[,paste(name,'total',sep='')]
  
  classificationDF = subset(classificationDF, select = originalNames)
  
  return(classificationDF)

}