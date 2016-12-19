#!/bin/bash

#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=80000

#Description: Calculate the NMDS
#Written by: Jorge Eduardo Amaya Romero
#Date: 14-12-2016

module load R/3.3.1-foss-2016a
Rscript Code/plot.R "Data/seqs_844G_no_gaps_no_reference_tamura_nei.csv"
#Rscript Code/plot.R "Data/seqs_844G_no_gaps_no_reference_no_differences.csv" 
