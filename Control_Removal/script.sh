#!/bin/bash

#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=seq_ev
#SBATCH --mem=80000

#Description: Creates a table with to compare the quality of the alignment with and with control region
#Written by: Jorge Eduardo Amaya Romero
#Date: 14-10-2016

module load Biopython/1.65-foss-2016a-Python-2.7.11
module load R/3.3.1-foss-2016a

#python Code/count_bases.py control <Reference> <File_with_control_region> <File_withouth_control_region>
python Code/count_bases.py control "gi|309056|gb|L20934.1|MSQMTCG" "Data/seqs_844G_original.fasta" "Data/seqs_844G_no_control.fasta" 
python Code/count_bases.py no_control "gi|309056|gb|L20934.1|MSQMTCG" "Data/seqs_844G_original.fasta" "Data/seqs_844G_no_control.fasta"

Rscript Code/plot.R 
Rscript Code/histo.R
