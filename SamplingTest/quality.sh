#!/bin/bash

#Description: Compare the quality of the assemblies
#Written by: Jorge Eduardo Amaya Romero
#Last time revised: 14-10-2016

#Theshold can be changed inside awk
module load Biopython/1.65-foss-2016a-Python-2.7.11

python Code/eval_assembly.py

grep -v ",0$" Results/Scores.csv | 
cut -d "," -f 3 | 
sort -n -r | 
head -n 1 |
awk '{if ($1 >= 35) 
	print "BAD: Assemblies are not of enough quality yet"; 
	else 
	print "GOOD: Assemblies have passing quality";}'


