rm(list=ls())
library(seqinr)
library(ape)

#Convert fasta to nexus
#(Refurbish: Change this line to point to your alignment and nexus output)
data = read.fasta("seqs_844G_no_gaps.fasta")
write.nexus.data(data, file="seqs_844G_no_gaps.nexus",format="Dna")
