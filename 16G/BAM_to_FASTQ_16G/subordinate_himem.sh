#!/bin/bash

#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --job-name=bam%j.log
#SBATCH --mem=500GB
#SBATCH --partition=himem

#Description: Subset the *.fastq.gz files
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

module purge
module load SAMtools/1.3.1-foss-2016a
module load BEDTools/2.25.0-foss-2016a
module load parallel/20160622-foss-2016a
module load Python/2.7.11-foss-2016a
module load picard/1.130-Java-1.7.0_80
module load Java/1.8.0_92

echo "Data/$1/samples/$2"

mkdir -p Results/$1/samples/$2

#(Refurbish: This is probably the script that needs more reworking and there is no correct formula. Be sure to produce mit_mapped_norm.fastq, mit_mapped_norm.fastq2, these files contains forward and reverse reads.)

samtools view -s $3 -h -o Results/$1/samples/$2/$2\.bam Data/$1/samples/$2/pest_realigned.bam
samtools sort -n -o Results/$1/samples/$2/mit_mapped_norm.qsort.bam Results/$1/samples/$2/$2\.bam

# Create the fastq and fastq2 filesj
java -jar Code/picard.jar SamToFastq I=Results/$1/samples/$2/mit_mapped_norm.qsort.bam FASTQ=Results/$1/samples/$2/mit_mapped_norm.fastq SECOND_END_FASTQ=Results/$1/samples/$2/mit_mapped_norm.fastq2
rm -f Results/$1/samples/$2/$2\.bam

# Create the interleaved file
Code/interleave-fastqgz-MITOBIM.py Results/$1/samples/$2/mit_mapped_norm.fastq Results/$1/samples/$2/mit_mapped_norm.fastq2 > Results/$1/samples/$2/interleaved.fastq
rm -f Results/$1/samples/$2/mit_mapped_norm.qsort.bam
