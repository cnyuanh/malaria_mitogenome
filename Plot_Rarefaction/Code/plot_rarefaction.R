rm(list=ls())
library(ggplot2)
source("Code/plot_functions.R")

means <- read.csv(file="Results/species/means.csv",sep=";",header=FALSE)
colnames(means) <- as.character(unlist(means[length(means$V1),]))
means <- means[-c(length(means[,1])),]

variance <- read.csv(file="Results/species/variance.csv",sep=";",header=FALSE)
colnames(variance) <- as.character(unlist(variance[length(variance$V1),]))
variance <- variance[-c(length(variance[,1])),]

#Remove the level species
variance$species <- droplevels(variance$species)
means$species <- droplevels(variance$species)
make_trend_plot(means,"species",variance)

means <- read.csv(file="Results/concens/means.csv",sep=";",header=FALSE)
colnames(means) <- as.character(unlist(means[length(means$V1),]))
means <- means[-c(length(means[,1])),]

variance <- read.csv(file="Results/concens/variance.csv",sep=";",header=FALSE)
colnames(variance) <- as.character(unlist(variance[length(variance$V1),]))
variance <- variance[-c(length(variance[,1])),]

#Remove the level species
variance$species <- droplevels(variance$species)
means$species <- droplevels(variance$species)
make_trend_plot(means,"concens",variance)
