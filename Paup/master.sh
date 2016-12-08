#!/bin/bash

#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=paup
#SBATCH --mem=20Gb
#SBATCH --output=paup.log

#Description: Creates a NJ tree
#Written by: Jorge Eduardo Amaya Romero
#Date: 10-15-2016

module load R/3.3.1-foss-2016a

cp /data/s3017141/Malaria_MitoGenome/Def_Assembly/malaria_mitogenome/Clean_Alignments/Updated_ID/* Data/.

Rscript Code/fasta_to_nexus.R "Data/seqs_16Gproject_no_gaps_no_reference.fasta" "seqs_16Gproject_no_gaps_no_reference.nexus"
Rscript Code/fasta_to_nexus.R "Data/seqs_765Gproject_no_gaps_no_reference.fasta" "seqs_765Gproject_no_gaps_no_reference.nexus"
Rscript Code/fasta_to_nexus.R "Data/seqs_844G_no_gaps_no_reference.fasta" "seqs_844G_no_gaps_no_reference.nexus"

cp Code/execute16G.nex .
cp Code/execute765G.nex .
cp Code/execute844G.nex .

./paup4a150_centos64 execute16G.nex > paup_report16G.txt
./paup4a150_centos64 execute765G.nex > paup_report765G.txt
./paup4a150_centos64 execute844G.nex > paup_report844G.txt
mv seqs_16Gproject_no_gaps_no_reference.nexus Results/.
mv seqs_765Gproject_no_gaps_no_reference.nexus Results/.
mv seqs_844G_no_gaps_no_reference.nexus Results/.

rm execute16G.nex
rm execute844G.nex
rm execute765G.nex
