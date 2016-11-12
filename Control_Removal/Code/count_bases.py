#!/bin/env python

#Description: Writes a series of tables with summary statistics of the assemblies
#Written by: Jorge Eduardo Amaya Romero
#Last time revised: 14-10-2016

from Bio 	import SeqIO
import itertools
import csv
import sys
from Bio.Seq	import MutableSeq

if sys.argv[1] == "no_control": 
	f = open('Results/statsf.csv', 'w')
	r = open('Results/gap_stats.csv', 'w')
else:
	g = open('Results/statsg.csv', 'w')


def hamming(seq1, seq2):
	return sum(itertools.imap(str.__ne__,seq1,seq2))

def kind(u, v):
    if u == '-':
        if v != '-':
            return 'I'  # insertion
    else:
        if v == '-':
            return 'D'  # deletion
        elif v != u:
            return 'P'  # polymorphism
    return 'U'          # unchanged	

records = [] #Load and separate the reference from the other sequences

if sys.argv[1] == "no_control":
	for record in SeqIO.parse(file(sys.argv[4]), "fasta"):
	        if record.id == sys.argv[2]:
        	        reference = record
	        else:
	                records.append(record)
else:
	for record in SeqIO.parse(file(sys.argv[3]), "fasta"):
	        if record.id == sys.argv[2]:
        	        reference = record
	        else:
	                records.append(record)

ref_gap = list(reference.seq)
#print(reference)
if sys.argv[1] == "no_control":
	count_nucleotide = 1

	gap_position = []
	for i in ref_gap:
		if i == "-":
			gap_position.append(count_nucleotide)
		count_nucleotide += 1

	report = {}
	try:
		writer = csv.writer(r)
		writer.writerow( (["Conce_Position","Nucleotide","Count"]) )
		for record in records:
			rec_gap = list(record.seq)
			for d in gap_position:
				if ref_gap[d-1] != rec_gap[d-1]: #Indexing starts in 0. Therefore nucleotide 1465 (first gap) will be ref_gap[1464]
					if not (d,rec_gap[d-1]) in report: #If the tuple exists
						report[(d,rec_gap[d-1])] = 1 #Initialize. 
					else:				     #or increase the counter by one
						report[(d,rec_gap[d-1])] += 1 
	
		for x in report.keys():
				writer.writerow(( x[0], x[1], report[x]))
	finally:
		r.close()
		
if sys.argv[1] == "no_control":
	try:
		writerf = csv.writer(f)
		writerf.writerow( (["Seq", "Ham", "Amb","Gaps","Insertions","Polymorphism","C","G","T","A","-"]) )
		for record in records:
			seq = record.seq
			ref = reference.seq

			ham = hamming(ref,seq) #Number of bases that are different compared to the reference
			dna_count = seq.count("A") + seq.count("G") + seq.count("C") + seq.count("T") + seq.count("-")
			amb = len(seq) - dna_count #Number of ambiguities
			mes = record.id.rsplit("_",2)[0]	
			count = dict.fromkeys('DIUP', 0)
			for u, v in zip(ref, seq):
				count[kind(u, v)] += 1
			if mes != sys.argv[2]:
				writerf.writerow( (mes,ham,amb,count['D'],count['I'],count['P']-amb,seq.count("C"),seq.count("G"),seq.count("T"),seq.count("A"),seq.count("-")) ) 
	finally:
		f.close()
else:
	try:
		writerg = csv.writer(g)
		writerg.writerow( (["Seq", "Ham", "Amb","Gaps","Insertions","Polymorphism","C","G","T","A","-"]) )
		for record in records:
			seq = record.seq
			ref = reference.seq

			ham = hamming(ref,seq) #Number of bases that are different compared to the reference
			dna_count = seq.count("A") + seq.count("G") + seq.count("C") + seq.count("T") + seq.count("-")
			amb = len(seq) - dna_count #Number of ambiguities
			mes = record.id.rsplit("_",2)[0]	
			count = dict.fromkeys('DIUP', 0)
			for u, v in zip(ref, seq):
				count[kind(u, v)] += 1
			if mes != sys.argv[2]:
				writerg.writerow( (mes,ham,amb,count['D'],count['I'],count['P']-amb,seq.count("C"),seq.count("G"),seq.count("T"),seq.count("A"),seq.count("-")) ) 
	finally:
		g.close()

