rm(list=ls())
library(seqinr)
library(ape)

args=commandArgs(trailingOnly=TRUE)
#Convert fasta to nexus
#(Refurbish: Change this line to point to your alignment and nexus output)
data = read.fasta(args[1])#"seqs_844G_no_gaps.fasta")
write.nexus.data(data, file=args[2],format="Dna")
#"seqs_844G_no_gaps.nexus"
