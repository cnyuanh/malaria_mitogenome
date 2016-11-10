#!/bin/bash

#SBATCH --time=00:20:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=sam
#SBATCH --mem=10000
#SBATCH --output=sam%j.log

#Description: Subset the sample from the putative mitochondrial reads
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

module purge
module load SAMtools/1.3.1-foss-2016a
module load BEDTools/2.25.0-foss-2016a
module load parallel/20160622-foss-2016a
module load Python/2.7.11-foss-2016a
module load picard/1.130-Java-1.7.0_80
module load Java/1.8.0_92

#(Refurbish: This is probably the script that needs more reworking and there is no correct formula. Be sure to produce mit_mapped_norm.fastq, mit_mapped_norm.fastq2, these files contains forward and reverse reads.)

# Create the qsort.bam file
mkdir Results/$1
gunzip -c Data/$1/mit_mapped_norm.sam.gz > Results/$1/mit_mapped_norm.sam

samtools view -s $2 -bT Data/reference/AGAMB_MTgenome.fasta Results/$1/mit_mapped_norm.sam > Results/$1/mit_mapped_norm.bam #Use this line to subsample
samtools sort -n -o Results/$1/mit_mapped_norm.qsort.bam Results/$1/mit_mapped_norm.bam
rm -f Results/$1/mit_mapped_norm.sam 

# Create the fastq and fastq2 files
java -jar Code/picard.jar SamToFastq I=Results/$1/mit_mapped_norm.qsort.bam FASTQ=Results/$1/mit_mapped_norm.fastq SECOND_END_FASTQ=Results/$1/mit_mapped_norm.fastq2
rm -f Results/$1/mit_mapped_norm.bam 

# Create the interleaved file
Code/interleave-fastqgz-MITOBIM.py Results/$1/mit_mapped_norm.fastq Results/$1/mit_mapped_norm.fastq2 > Results/$1/interleaved.fastq
rm -f Results/$1/mit_mapped_norm.qsort.bam
