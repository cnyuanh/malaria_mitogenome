#!/bin/bash

#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --job-name=bam
#SBATCH --mem=100GB
#SBATCH --output=bam%j.log

#Description: Subset the *.fastq.gz files
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016
#Additional notes: Process the file names of Epiroticus and Christyi

module purge
module load SAMtools/1.3.1-foss-2016a
module load BEDTools/2.25.0-foss-2016a
module load parallel/20160622-foss-2016a
module load Python/2.7.11-foss-2016a
module load picard/1.130-Java-1.7.0_80
module load Java/1.8.0_92

echo "Data/$1/samples/$2"

mkdir -p Results/$1/samples/$2

#(#Refurbish the lines with path to files) 

if [ $1 == "16G_epiroticus" ];	then
        if [ $(bc <<< "$3 == 0.025") -eq 1 ]; then
#	zcat /path/to/$1/samples/$2/pe_1_trimmed.fq.gz | sed -n 1,$((lines*$3)) > Results/$1/samples/$2/mit_mapped_norm.fastq
#	zcat /path/to/$1/samples/$2/pe_2_trimmed.fq.gz | sed -n 1,$((lines*$3)) > Results/$1/samples/$2/mit_mapped_norm.fastq2
	fi
else #For 16_christyi
        if [ $(bc <<< "$3 == 0.025") -eq 1 ]; then
#	zcat /path/to/$1/samples/$2/pe_1_trimmed.fq.gz | sed -n 1,$((lines*$3)) > Results/$1/samples/$2/mit_mapped_norm.fastq
#	zcat /path/to/$1/samples/$2/pe_2_trimmed.fq.gz | sed -n 1,$((lines*$3)) > Results/$1/samples/$2/mit_mapped_norm.fastq2
	fi
fi

# Create the interleaved file
	#Indicate from which file the read was extracted by adding /1 or /2 to its end
cat Results/$1/samples/$2/mit_mapped_norm.fastq | awk '{print (NR%2 == 1) ? $0"/1" : $0}' > Results/$1/samples/$2/mit_mapped_norm2.fastq
cat Results/$1/samples/$2/mit_mapped_norm.fastq2 | awk '{print (NR%2 == 1) ? $0"/2" : $0}' > Results/$1/samples/$2/mit_mapped_norm2.fastq2
rm Results/$1/samples/$2/mit_mapped_norm.fastq Results/$1/samples/$2/mit_mapped_norm.fastq2
	#Simplify every third line of the fastq with "+"
cat Results/$1/samples/$2/mit_mapped_norm2.fastq | awk '{print (NR%4 == 3) ? "+" : $0}' > Results/$1/samples/$2/mit_mapped_norm3.fastq
cat Results/$1/samples/$2/mit_mapped_norm2.fastq2 | awk '{print (NR%4 == 3) ? "+" : $0}' > Results/$1/samples/$2/mit_mapped_norm3.fastq2
rm Results/$1/samples/$2/mit_mapped_norm2.fastq Results/$1/samples/$2/mit_mapped_norm2.fastq2
	#Eliminate the  white spaces of the header
cat Results/$1/samples/$2/mit_mapped_norm3.fastq | awk '{print (NR%4 == 1) ? $1 $2 $3 : $0}' > Results/$1/samples/$2/mit_mapped_norm4.fastq
cat Results/$1/samples/$2/mit_mapped_norm3.fastq2 | awk '{print (NR%4 == 1) ? $1 $2 $3 : $0}' > Results/$1/samples/$2/mit_mapped_norm4.fastq2
rm Results/$1/samples/$2/mit_mapped_norm3.fastq Results/$1/samples/$2/mit_mapped_norm3.fastq2

mv Results/$1/samples/$2/mit_mapped_norm4.fastq Results/$1/samples/$2/mit_mapped_norm.fastq
mv Results/$1/samples/$2/mit_mapped_norm4.fastq2 Results/$1/samples/$2/mit_mapped_norm.fastq2

Code/interleave-fastqgz-MITOBIM.py Results/$1/samples/$2/mit_mapped_norm.fastq Results/$1/samples/$2/mit_mapped_norm.fastq2 > Results/$1/samples/$2/interleaved.fastq

sleep 1
