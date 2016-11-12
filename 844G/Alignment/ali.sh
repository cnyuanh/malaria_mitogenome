#!/bin/bash

#SBATCH --time=1-12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=ali
#SBATCH --mem=100Gb
#SBATCH --output=ali.log

#Description: Obtain the assemblies and align the sequences to the reference
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

module purge
module load parallel/20160622-foss-2016a
module load MUSCLE/3.8.31-foss-2016a

readarray individuals < Data/names.csv

#(Refurbish: Link the results of the previous step and initialize a multifasta file with the reference sequence.)
for i in ${individuals[@]} 
        do
        	./subordinate_ali.sh $i 
        done

readarray individuals_all < Data/names_all.csv

for i in ${individuals_all[@]} 
        do
                cat Results/${i}.fasta >> Results/seqs.fasta
        done

muscle -in Results/seqs.fasta -out Results/seqs.afa
