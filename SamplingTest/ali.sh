#!/bin/bash

#SBATCH --time=12:00:00
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

readarray individuals < Data/names_$1\.csv

mkdir -p Results/Alignment/Data
mkdir -p Results/Alignment/Results
cp -r Code/ Results/Alignment/.
cp *.sh Results/Alignment/.
cd Results/Alignment

#(Refurbish: Link the results of the previous step and initialize a multifasta file with the reference sequence.)
ln -s /path/to/SamplingTest/Results/Assembly/Results/* Data/.
cp /path/to/AGAMB_MTgenome.fasta Results/seqs.fasta

for i in ${individuals[@]} 
        do
        	./subordinate_ali.sh $i 
        done

for i in ${individuals[@]} 
        do
                cat Results/${i}.fasta >> Results/seqs.fasta
        done

muscle -in Results/seqs.fasta -out Results/seqs.afa
cp Results/seqs.afa ../seqs_$1\.afa
cd ../../
