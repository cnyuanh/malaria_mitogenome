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

Rscript fasta_to_nexus.R
./paup4a150_centos64 execute.nex > paup_report.txt
