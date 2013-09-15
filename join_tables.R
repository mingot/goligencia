JoinTables <- function(classificationDF, matchDF){
  
  # merge with the classification results
  tablon = merge(x=matchDF, y=classificationDF, by.x=c('team1','season','day'), by.y=c('name','season','day'), all.x = TRUE)
  tablon = merge(x=tablon, y=classificationDF, by.x=c('team2','season','day'), by.y=c('name','season','day'), all.x = TRUE)
  
  # put the Quiniela result: 0 tied, 1 local team wins, 2 visiting team
  tablon$result = 0
  for(i in 1:nrow(tablon)){
    if(tablon[i,'result1']==tablon[i,'result2']) tablon[i,'result'] = 0
    else if(tablon[i,'result1'] > tablon[i,'result2']) tablon[i,'result'] = 1
    else if(tablon[i,'result1'] < tablon[i,'result2']) tablon[i,'result'] = 2
  }
  
  # rename the names in tablon to go from .x and .y to 1 and 2
  namesTablon = names(tablon)
  namesTablon = unlist(lapply(namesTablon, function(x) gsub("[.]x","2",x)))
  namesTablon = unlist(lapply(namesTablon, function(x) gsub("[.]y","1",x)))
  names(tablon) = namesTablon
  
  return(tablon)
}