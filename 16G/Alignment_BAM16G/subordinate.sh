#!/bin/bash

#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=ali
#SBATCH --mem=10000

#Description: Obtain the last assembly with IUPAC ambiguities
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

module purge
module load parallel/20160622-foss-2016a
module load MUSCLE/3.8.31-foss-2016a

cd Results
tar -xzvf ../Data/$1/samples/$2\.tar.gz $2/iteration*/$2-AGAM_assembly/$2-AGAM_d_results/$2-AGAM_out_AllStrains.unpadded.fasta
mv $2/iteration*/$2-AGAM_assembly/$2-AGAM_d_results/$2-AGAM_out_AllStrains.unpadded.fasta .
rm -r $2 
sed "s/^\(>.*\)$/>$1_$2/" $2-AGAM_out_AllStrains.unpadded.fasta > $2\.fasta
rm $2-AGAM_out_AllStrains.unpadded.fasta
cd ../

