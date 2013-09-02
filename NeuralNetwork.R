# Google Style: variable.name, FunctionName, kConstantName

# ================================================================================= #
# ABSTRACT
# ================================================================================= #
# This script contains the implementation of a neural network multinomial model
# for soccer results prediction
# ================================================================================= #

# ================================================================================= #
# Loading packages and data
# ================================================================================= #
library(nnet)

# setwd("C:/Users/Ferran/FerranAMazaira/Goligencia")
data.learn = read.csv("taula.csv", header = TRUE, sep = ";")

# Data formating
data.learn$pg1 = as.numeric(gsub(",",".", data.learn$pg1))
data.learn$pp1 = as.numeric(gsub(",",".", data.learn$pp1))
data.learn$pe1 = as.numeric(gsub(",",".", data.learn$pe1))
data.learn$pg2 = as.numeric(gsub(",",".", data.learn$pg2))
data.learn$pp2 = as.numeric(gsub(",",".", data.learn$pp2))
data.learn$pe2 = as.numeric(gsub(",",".", data.learn$pe2))
data.learn$punts1 = as.numeric(gsub(",",".", data.learn$punts1))
data.learn$punts2 = as.numeric(gsub(",",".", data.learn$punts2))
data.learn$avgf1 = as.numeric(gsub(",",".", data.learn$avgf1))
data.learn$avgc1 = as.numeric(gsub(",",".", data.learn$avgc1))
data.learn$avgf2 = as.numeric(gsub(",",".", data.learn$avgf2))
data.learn$avgc2 = as.numeric(gsub(",",".", data.learn$avgc2))

# Training set preparation
x.learn = data.learn[,c(7:21)]
y.learn = as.factor(data.learn[,22])


# ================================================================================= #
# Neural Network Multinomial Model
# ================================================================================= #
ones = rep(1, length(y.learn))

model.NN = multinom(y.learn~.+I(difposition^2),data = x.learn, weigths = ones)

pred = predict(model.m, type = "class")
error = as.numeric(p) - as.numeric(y.learn)
zeros = which(error == 0)
accuracy = length(zeros)/length(p)
accuracy
