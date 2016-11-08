#!/bin/bash

#SBATCH --time=00:01:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=clean
#SBATCH --mem=10000
#SBATCH --output=clean.log

cd Results

rm -r Alignment  
rm -r Assembly  
rm -r Remove  
rm -r SAM_to_FASTQ

cd ../
