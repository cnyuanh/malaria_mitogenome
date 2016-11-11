#!/bin/bash

#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=ali
#SBATCH --mem=10000

#Description: Obtain the last assembly with the minimum amount of IUPAC ambiguities
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

module purge
module load parallel/20160622-foss-2016a
module load MUSCLE/3.8.31-foss-2016a

cd Results
tar -xzvf ../Data/$1/samples/$2/$3\.tar.gz $3/iteration*/$3-AGAM_assembly/$3-AGAM_d_results/$3-AGAM_out_AllStrains.unpadded.fasta

mv $3/iteration*/$3-AGAM_assembly/$3-AGAM_d_results/$3-AGAM_out_AllStrains.unpadded.fasta .
rm -r $3 
sed "s/^\(>.*\)$/>$1_$2_$3/" $3-AGAM_out_AllStrains.unpadded.fasta > $3\.fasta
rm $3-AGAM_out_AllStrains.unpadded.fasta
cd ../
