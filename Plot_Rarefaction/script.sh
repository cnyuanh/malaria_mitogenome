#!/bin/bash

#SBATCH --time=00:50:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=extrac
#SBATCH --mem=10000
#SBATCH --output=extrac.log

module load Biopython/1.65-goolfc-2.7.11-Python-2.7.9
module load R/3.3.1-foss-2016a

#Description: Creates a table with the Rarefaction results
#Written by: Jorge Eduardo Amaya Romero
#Date: 14-10-2016

rm -r Results/*
#Link the results of the rarefaction analysis
ln -s /data/s3017141/Malaria_MitoGenome/Def_Assembly/malaria_mitogenome/Rarefaction/Results/* Data/. 

for i in Data/species/*
	do
		for d in ${i}/*
		do 
		species=${i#Data/species/}
		number=${d#Data/species/${i#Data/species/}/}
		if [ "${number}" != 'Seqs.fasta' ] && [ "${number}" != 'Seqs.stats' ]; then
			for z in $(ls -v Data/species/${species}/${number}/*)
			do
				if $(echo ${z} | grep -q "stats"); then
					echo ${z}
					mkdir -p Results/species/${species}/${number}
					python Code/stats_extrac.py ${d} Results/species/${species}/${number}/ ${species} ${z} ${number}
				fi
			done
			Rscript Code/calculate.R Results/species/${species}/${number}/Stats.csv Results/species/${species}/Stats.csv ${number} ${species}
			grep "Mean" Results/species/${species}/${number}/Stats.csv >> Results/species/means.csv
			grep "Median" Results/species/${species}/${number}/Stats.csv >> Results/species/median.csv
			grep "Variance" Results/species/${species}/${number}/Stats.csv >> Results/species/variance.csv
		fi
		done
	done

grep "names" Results/species/Admixed/10/Stats.csv >> Results/species/means.csv
grep "names" Results/species/Admixed/10/Stats.csv >> Results/species/median.csv
grep "names" Results/species/Admixed/10/Stats.csv >> Results/species/variance.csv

for i in Data/concens/*
	do
		for d in ${i}/*
		do 
		concens=${i#Data/concens/}
		number=${d#Data/concens/${i#Data/concens/}/}
		if [ "${number}" != 'Seqs.fasta' ] && [ "${number}" != 'Seqs.stats' ]; then
			for z in $(ls -v Data/concens/${concens}/${number}/*)
			do
				if $(echo ${z} | grep -q "stats"); then
					echo ${z}
					mkdir -p Results/concens/${concens}/${number}
					python Code/stats_extrac.py ${d} Results/concens/${concens}/${number}/ ${concens} ${z} ${number}
				fi
			done
			Rscript Code/calculate.R Results/concens/${concens}/${number}/Stats.csv Results/concens/${concens}/Stats.csv ${number} ${concens}
			grep "Mean" Results/concens/${concens}/${number}/Stats.csv >> Results/concens/means.csv
			grep "Median" Results/concens/${concens}/${number}/Stats.csv >> Results/concens/median.csv
			grep "Variance" Results/concens/${concens}/${number}/Stats.csv >> Results/concens/variance.csv
		fi
		done
	done
grep "names" Results/concens/AOM/10/Stats.csv >> Results/concens/means.csv
grep "names" Results/concens/AOM/10/Stats.csv >> Results/concens/median.csv
grep "names" Results/concens/AOM/10/Stats.csv >> Results/concens/variance.csv

Rscript Code/plot_rarefaction.R
