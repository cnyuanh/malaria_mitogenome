#!/bin/bash

#Description: Perform a rarefaction analysis by species and population
#Written by: Jorge Eduardo Amaya Romero
#Date: 14-10-2016

module load Biopython/1.65-goolfc-2.7.11-Python-2.7.9

#rm -r Results/*
#rm -r Data/*
#(Refurbish: Change this line to point to your aligment)
cp /data/s3017141/Malaria_MitoGenome/Def_Assembly/malaria_mitogenome/Clean_Alignments/Updated_ID/seqs_844G_no_gaps_no_reference.fasta Data/.
#ln -s /data/s3017141/Malaria_MitoGenome/Def_Assembly/malaria_mitogenome/Clean_Alignments/panoptes.csv Data/.
python Code/subset_fasta.py Data/seqs_844G_no_gaps_no_reference.fasta SAMN01087920 SRS228219

rarefaction () {
	iterations=10
	for sample_size in $(seq 3 1 50)
		do 
		for i in $1
			do
			if [ "$(grep ">" ${i}/Seqs.fasta | wc -l)" -ge ${sample_size} ]; then #If # of sequences is -ge than sample sample_size
				mkdir ${i}/${sample_size}
				for p in $(seq 1 1 $(expr ${iterations}))
					do
					cat ${i}/Seqs.fasta |\
					awk '/^>/ { if(i>0) printf("\n"); i++; printf("%s\t",$0); next;} {printf("%s",$0);} END { printf("\n");}' |\
					shuf > ${i}/${sample_size}/seqs.tmp
					head -n ${sample_size} ${i}/${sample_size}/seqs.tmp |\
					sed 's/^\(>[A-Za-z0-9]*\.*[A-Za-z0-9]*_*C*\s*\[.*\]\)\(\s*\)\(.*$\)/\1\n\3/' > ${i}/${sample_size}/Seqs${p}.fasta  
					echo ${i}/${sample_size}/Seqs${p}.fasta
					./infoseq_diversity ${i}/${sample_size}/Seqs${p}.fasta > ${i}/${sample_size}/Seqs${p}.stats
				done
				rm ${i}/${sample_size}/seqs.tmp
			fi
		done
	done
}

rarefaction "Results/species/*"
rarefaction "Results/concens/*"

#Calculate the stats for all the individuals of one species or population

for i in Results/species/*
	do
		echo ${i}
		./infoseq_diversity ${i}/Seqs.fasta > ${i}/Seqs.stats
	done

for i in Results/concens/*
	do
		echo ${i}
		./infoseq_diversity ${i}/Seqs.fasta > ${i}/Seqs.stats
	done
