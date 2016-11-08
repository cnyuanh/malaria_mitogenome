#!/bin/env python

#Description: Writes a series of tables with summary statistics of the assemblies
#Written by: Jorge Eduardo Amaya Romero
#Last time revised: 14-10-2016

from Bio 	import SeqIO
from Bio	import pairwise2
import itertools
import csv
import sys
from Bio.Seq	import MutableSeq
import os

path_to_file="".join(["Results/Count_",sys.argv[2],'.csv'])
print(path_to_file)
g = open(path_to_file, 'w')

def findcontrol(seq,end):
	count = seq.count("A",start=0,end=end) + seq.count("G",start=0,end=end) + seq.count("C",start=0,end=end) + seq.count("T",start=0,end=end)
	if count != 14844:
		end += 1
		return findcontrol(seq,end)
	else:
		return end
	
records = [] #Load and separate the reference from the other sequences
for record in SeqIO.parse(file(sys.argv[1]), "fasta"):
	if record.id == "gi|309056|gb|L20934.1|MSQMTCG":
		reference = record
	else:
		records.append(record)

coding_seq = findcontrol(reference.seq,14844)

reference.seq = reference.seq[0:coding_seq]

try:
	writerg = csv.writer(g)
	for record in records:
		seq = record.seq[0:coding_seq]
		count = seq.count("A") + seq.count("G") + seq.count("C") + seq.count("T") + seq.count("-")
		writerg.writerow((record.id,len(seq) - count)) #Print the id and the number of ambiguities
finally:
	g.close()
