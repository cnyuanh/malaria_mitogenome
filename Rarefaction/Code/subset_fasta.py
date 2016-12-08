#!/bin/env python

#Description: Separate sequences by populations
#Written by: Jorge Eduardo Amaya Romero
#Last time revised: 14-10-2016

from Bio 	import SeqIO
import sys
import os
import re

sequences= sys.argv[1] 

os.makedirs("Results/species")
os.makedirs("Results/concens")

with open(sequences) as original, open("Results/Ingroup.fasta", 'a') as ingroup, open("Results/Outgroup.fasta", 'a') as outgroup:
	records = SeqIO.parse(original, "fasta")
	for record in records:
		comment = str(record.description)
		#Take the species and the population from the comment in the fasta header.
		species = comment.split()[2]
		population = comment.split()[3]
		species_dir = "/".join(["Results/species",species])
		concens_dir = "/".join(["Results/concens",population])
		if not re.search('An.christyi|An.epiroticus',comment):
			SeqIO.write(record,ingroup,"fasta")
			if not os.path.isdir(species_dir): os.makedirs(species_dir)
			if not os.path.isdir(concens_dir): os.makedirs(concens_dir)
			with open("/".join([species_dir,"Seqs.fasta"]), 'a') as species_file, open("/".join([concens_dir,"Seqs.fasta"]), 'a') as concens_file:
				SeqIO.write(record,species_file,"fasta")
				SeqIO.write(record,concens_file,"fasta")
		else:
			SeqIO.write(record,outgroup,"fasta")
