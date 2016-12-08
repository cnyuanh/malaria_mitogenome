#!/bin/env python

#Description: Separate sequences by populations, species or projecrt
#Written by: Jorge Eduardo Amaya Romero
#Last time revised: 14-10-2016

from Bio 	import SeqIO
import csv
import sys
import os
import re

#Create dictionaries for every subset of sequences
names={} #All sequences
names_16G={} #Fontaine et. al. (2015) + Bwambae
names_765G={} #MalariaGen

#Create a dictionary with the species and population
with open(sys.argv[1], 'r') as csvfile:
	content = csv.reader(csvfile, delimiter='\t')
	next(content, None)
	for row in content:
		#Adapt this line to put in the comment the information obtained from the csv file)
		#Be sure that the keys in the dictionary (row[1] in this example) match the fasta header
		if not row[7]:
			sys.exit("Impossible to fill all comments. Check your *.csv and consider replacing missing values with ?")
		names[row[1]] = " ".join(["[",row[0],row[2],row[3],row[4],row[5],row[6],row[7],"]"])
		if len(row[8]) == 2: #Specify the criteria for every subset. In my case, the eigth column of the csv file had information about the origion of the sequence. Consider creating an elif if you have more than two groups.
			names_16G[row[1]] = " ".join(["[",row[0],row[2],row[3],row[4],row[5],row[6],row[7],"]"])
		else:
			names_765G[row[1]] = " ".join(["[",row[0],row[2],row[3],row[4],row[5],row[6],row[7],"]"])

original_file = "/".join(["Data",sys.argv[2]])
corrected_file= "/".join(["Results",sys.argv[2]])
corrected16G_file = "/".join(["Results",sys.argv[3]])
corrected765G_file = "/".join(["Results",sys.argv[4]])

#Separate the sequences from the outgroup
with open(original_file) as original, open(corrected_file, 'w') as corrected, open(corrected16G_file, 'w') as corrected_16G, open(corrected765G_file, 'w') as corrected_765G:
	records= SeqIO.parse(original, "fasta")
	for record in records:
		record.description = names[record.id]
		SeqIO.write(record,corrected, "fasta") #All sequences
		if record.id in names_16G.keys(): #Separate sequences depending on the dictionary the belong to.
			SeqIO.write(record,corrected_16G, "fasta")
		else:
			SeqIO.write(record,corrected_765G, "fasta")
		if (str(record.id) == "SAMN01087920") or (str(record.id) == "SRS228219"): #Since my outgroups come from 16G_project, they must be forced into the 765G_project file. This is a dirty solution to solve a problem with my dataset and you can happily.
			SeqIO.write(record,corrected_765G, "fasta")
