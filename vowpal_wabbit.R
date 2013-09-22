
# # Test of it works 
# 
# library(mlbench)
# data(BreastCancer)
# tablon = BreastCancer
# names(tablon) = c("id","cell_thickness","cell_size","cell_shape","marg_adhesion","epith_c_size","bare_nuclei","bl_cromatin","normal_nucleoli","mitoses","class")
# predictVariable = "class"
# outputFilename = "data_vowpal.txt"

ExportToVowpal <- function(tablon, predictVariable="target", outputFilename="output_vowpal.txt"){

  # Export a data frame as a txt with the output format of Vowpal Wabbit
  # If the dataframe conatins a column called importance, it is incorporated in VW output
  # An example has default importance 1. More importance is repeating it.
  
  featuresDataFrame = tablon[,!(names(tablon) %in% c(predictVariable))]
  targetVariable = as.character(tablon[,predictVariable])
  targetVariable = ConvertToNumber(targetVariable)
  
  strings = c()
  for(i in 1:nrow(featuresDataFrame)){
    str = paste(targetVariable[i], '|')
    for(j in 1:ncol(featuresDataFrame)){
      varStr = paste(names(featuresDataFrame)[j],":",featuresDataFrame[i,j], sep="")
      str = paste(str,varStr)
    }
    strings = c(strings,str)
  }
  
  print(head(strings))
  
  exportDF = data.frame(title = strings)
  write.table(exportDF, file = outputFilename, quote=FALSE, row.names=FALSE, col.names=FALSE)
}

ConvertToNumber <- function(targetVariable){
  
  # Input: array of strings
  # Outpu: array of numbers, map strings to numbers
  # Example: ConvertToNumber(c("caca","cola","caca")) -> (0,1,0)

  # Testing   
  # test=c("casa","casa","cole","casa","casa","cole","casa","casa","cole","casa","cole","casa","urna")
  # targetVariable = test
  
  # map from string to number using a data frame
  dummy = data.frame(foo=NA) 
  classes = unique(targetVariable)
  for(i in 1:length(classes))
    dummy[,classes[i]] = i
  
  # apply the map
  targetVariableArray = unlist(lapply(targetVariable,function(x) dummy[,x]-1))

  return(targetVariableArray)
}