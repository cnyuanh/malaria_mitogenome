#!/bin/bash

#Check the quality of the assemblies
#Theshold can be changed inside awk

grep -v ",0" Results/Count_$1\.csv | 
cut -d "," -f 2 | 
sort -n -r | 
head -n 1 |
awk '{if ($1 >= 35) 
	print "BAD: Assemblies are not of enough quality yet"; 
	else 
	print "GOOD: Assemblies have passing quality";}'


