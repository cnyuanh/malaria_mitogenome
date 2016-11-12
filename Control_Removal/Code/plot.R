#!/usr/bin/env Rscript

alicontrol <- read.csv("Results/statsg.csv", header =T)
alicontrol$source <- "Control"
alinocontrol <- read.csv("Results/statsf.csv", header =T)
alinocontrol$source <- "NoControl"
ali <- rbind(alicontrol,alinocontrol)

png("Results/Ham.png")
  boxplot(ali[,2]~ali$source, main="Hamming distance", xlab= "Hammming distance")
dev.off()

png("Results/Amb.png")
  boxplot(ali[,3]~ali$source, main="Ambiguities", xlab= "Ambiguities")
dev.off()

png("Results/Gaps.png")
  boxplot(ali[,4]~ali$source, main="Gaps", xlab= "Gaps")
dev.off()

png("Results/Insertions.png")
  boxplot(ali[,5]~ali$source, main="Insertions", xlab= "Insertions")
dev.off()

png("Results/Polymorphism.png")
  boxplot(ali[,6]~ali$source, main="Polymorphism", xlab= "Polymorphism")
dev.off()
