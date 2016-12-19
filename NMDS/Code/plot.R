#!/usr/bin/env Rscript

library(ape)
library(ecodist)
library(adegenet)
library(scales)

names <- read.csv("Data/names.csv",sep=",",header=F,stringsAsFactors=FALSE)
species <- as.character(names[,2])[-c(1,2)]
population <- as.character(names[,3])[-c(1,2)]
names <- as.character(names[,1])


mat <- data.matrix(read.table("Data/seqs_844G_no_gaps_no_reference_tamura_nei.csv",fill =TRUE,sep=",", col.names=paste("v",1:845)))
mat <- mat[,-1]

colnames(mat) <- names; rownames(mat) <- names
mat <- mat[-c(1,2),-c(1,2)]
mat2 <- as.dist(mat)

png("Results/nj.png")
plot(nj(mat2))
dev.off()

###################
# nMDS 2D
###################
nmds_out=nmds(mat2, mindim=2, maxdim=2) # Runs NMDS 
scores=nmds.min(nmds_out) # generate scores
	# Minimum stress for given dimensionality: 
	# r^2 for minimum stress configuration:
nmds_out$stress # the last value indicates the final stress

save(scores,nmds_out,file="Results/Scores.Rda")

#In case you want to load a previous version of Scores, comment the previous lines and uncomment this line:
#load("Results/Scores.Rda")

#2D PLOTS - Species
colour <- c("darkgray","goldenrod1","blueviolet","coral4","red4","darkorchid3","blue4","darkgreen","cadetblue4")[as.factor(species)]
shapes <- c(8,15,16,17,18,8,15,16,17)[as.factor(species)]
color.legend <- c("darkgray","goldenrod1","blueviolet","coral4","red4","darkorchid3","blue4","darkgreen","cadetblue4")
shape.legend <- c(8,15,16,17,18,8,15,16,17)

colour <- adjustcolor(colour,alpha.f=0.65)
pdf("Results/MDS_Species.pdf")
par(xpd=TRUE,mar = par()$mar + c(0,0,0,7))
plot(scores, col=colour, pch=shapes, cex=1, xlab="nMDS1", ylab="nMDS2", main="NMDS_Species")
legend("topright", inset=c(-0.4,0), legend=levels(as.factor(species)), col= color.legend, pch=shape.legend, cex=0.8)
dev.off()

#2D PLOTS - Population
colour <- c("tomato","goldenrod3","red4","darkorchid3","goldenrod1","blue4","red","darkorchid1","orchid2","purple4","darkgray","pink","darkgreen","blueviolet","green","gold","peachpuff","coral4","violet","cadetblue4")[as.factor(population)]
shapes <- c(8,15,16,17,18,8,15,16,17,18,8,15,16,17,18,8,15,16,17,18)[as.factor(population)]
color.legend <- c("tomato","goldenrod3","red4","darkorchid3","goldenrod1","blue4","red","darkorchid1","orchid2","purple4","darkgray","pink","darkgreen","blueviolet","green","gold","peachpuff","coral4","violet","cadetblue4") 
shape.legend <- c(8,15,16,17,18,8,15,16,17,18,8,15,16,17,18,8,15,16,17,18)

colour <- adjustcolor(colour,alpha.f=0.65)
pdf("Results/MDS_Population.pdf")
par(xpd=TRUE,mar = par()$mar + c(0,0,0,7))
plot(scores, col=colour, pch=shapes, cex=1, xlab="nMDS1", ylab="nMDS2", main="NMDS_Population")
legend("topright", inset=c(-0.4,0), legend=levels(as.factor(population)), col= color.legend, pch=shape.legend, cex=0.8)
dev.off()
