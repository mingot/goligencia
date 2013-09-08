
rm(list = ls()) # clear workspace
source('data_cleaning.R')
source('classification_normalization.R')
source('join_tables.R')
source('cross_validation.R')

classificationDF = read.csv("data/classification.csv", header = TRUE, sep=',')
matchDF = read.csv("data/match.csv", header=TRUE, sep=',')
matchDF = matchDF[c('team1', 'team2', 'season','day', 'result1','result2')]

# Clean
classificationDF = CleanClassification(classificationDF)
matchDF = CleanMatchDF(matchDF)

# Normalize
classificationDF = NormalizeClassification(classificationDF)

# Join tables
tablon = JoinTables(classificationDF, matchDF)

# Extract match features

# Train and cross validate
TrainCrossValidation(5, tablon, 'result')

