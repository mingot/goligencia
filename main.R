
rm(list = ls()) # clear workspace
source('data_cleaning.R')
source('classification_normalization.R')
source('join_tables.R')
source('cross_validation.R')
source('feature_creation.R')

classificationDF = read.csv("data/classification.csv", header = TRUE, sep=',', fileEncoding = "UTF-8")
matchDF = read.csv("data/match.csv", header=TRUE, sep=',',fileEncoding = "UTF-8")
matchDF = matchDF[c('team1', 'team2', 'season','day', 'result1','result2')]

# Clean
classificationDF = CleanClassification(classificationDF)
matchDF = CleanMatchDF(matchDF)

# Feature creation 
# To be done before normalization
classificationDF = FeaturesClassification(classificationDF)

# Normalize
classificationDF = NormalizeClassification(classificationDF)

# Join tables
tablon = JoinTables(classificationDF, matchDF)
tablon = FeaturesTaula(tablon)
# Extract match features

# Train and cross validate
TrainCrossValidation(5, tablon, 'result')



