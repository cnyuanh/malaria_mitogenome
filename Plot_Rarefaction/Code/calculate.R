#!/usr/bin/env Rscript
rm(list=ls())

library(matrixStats)

args <- commandArgs(trailingOnly=TRUE)
print(args[1])
data <- read.csv(args[1],sep=";",header=T)
data[,1] <- as.character(data[,1])
data <- data[-seq(2,length(data$names)-1,by=2),]
indx <- sapply(data,is.factor)
data[indx] <- lapply(data[indx], function(x) as.numeric(as.character(x)))

mean_row <- c("Mean",colMeans(data[,-c(1)],na.rm=TRUE))
median_row <- c("Median",colMedians(as.matrix(data[,-c(1)]),na.rm=TRUE))
var_row <- c("Variance",colVars(as.matrix(data[,-c(1)]),na.rm=TRUE))

data <- rbind(data,mean_row)
data <- rbind(data,median_row)
data <- rbind(data,var_row)
data$number <- rep(args[3],length(data$names))
data$species <- rep(args[4],length(data$names))
#str(data)

#if(file.exists(args[2])){
#	summaries <- read.csv(args[2],sep=";")
#	summaries[,1] <- as.character(summaries[,1])
#	summaries <- rbind(summaries,mean_row)
#	summaries <- rbind(summaries,median_row)
#	summaries <- rbind(summaries,var_row)
#}else{
#	summaries <- data.frame()
#	summaries <- rbind(summaries,mean_row)
#	summaries <- rbind(summaries,median_row)
#	summaries <- rbind(summaries,var_row)
#}
write.table(data,file=args[1],sep=";",row.names=FALSE)
