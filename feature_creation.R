FeaturesClassification <- function(classificationDF){
  # Creates new features using classificationDF. Namely:
  # barmad := 1 if is Barca o Madrid
  # rg, rp := number of successive matches wining, loosing 
  
  # Barca o Madrid indicator
  classificationDF['barmad'] = rep(0, length(classificationDF['name'])) 
  classificationDF$barmad[which(classificationDF['name'] == "R. Madrid" ||
    classificationDF['name'] == "Barcelona")] = 1
  
  # Creating "ratxes" features
  classificationDF = classificationDF[order(classificationDF$name, classificationDF$season, classificationDF$day),]
  
  classificationDF['rg'] = rep(0, nrow(classificationDF['name']))
  for(i in 1:nrow(classificationDF['name'])){
    if(classificationDF$day[i] == 0)
      classificationDF$rg[i] = classificationDF$pg[i]
    else 
      if(classificationDF$pg[i]>classificationDF$pg[i-1])
        classificationDF$rg[i] = classificationDF$rg[i-1] + 1
  }
  
  classificationDF['rp'] = rep(0, nrow(classificationDF['name']))
  for(i in 1:nrow(classificationDF['name'])){
    if(classificationDF$day[i] == 0)
      classificationDF$rp[i] = classificationDF$pp[i]
    else 
      if(classificationDF$pp[i]>classificationDF$pp[i-1])
        classificationDF$rp[i] = classificationDF$rp[i-1] + 1
  }
  
  return(classificationDF)
    
}

