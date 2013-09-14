FeaturesClassification <- function(classificationDF){
  # Creates new features using classificationDF. Namely:
  # barmad := 1 if is Barca o Madrid
  # rg, rp, rge := number of successive matches wining, loosing or not loosing 
  
  # Barca o Madrid indicator
  classificationDF['barmad'] = rep(0, length(classificationDF['name'])) 
  classificationDF$barmad[which(classificationDF['name'] == "R. Madrid" ||
    classificationDF['name'] == "Barcelona")] = 1
  
  # r
  
}

