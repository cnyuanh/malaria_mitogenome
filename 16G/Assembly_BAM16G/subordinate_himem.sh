#!/bin/bash

#SBATCH --time=1-12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --job-name=ass.log
#SBATCH --mem=500GB
#SBATCH --partition=himem
#SBATCH --output=ass%j.log

#Description: Performs the assembly
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

module purge
module load SAMtools/1.3.1-foss-2016a
module load Perl/5.22.1-foss-2016a
module load Python/3.5.1-intel-2016a
module load parallel/20160622-foss-2016a
module load MIRA/4.0.2-foss-2016a-Python-2.7.11

echo "Data/$1/samples/$2"
mkdir -p Results/$1/samples/$2
cd Results/$1/samples/$2

#Link necessary files
ln -s ../../../../Data/$1/samples/$2/interleaved.fastq reads.fastq 
ln -s ../../../../Data/$1/samples/$2/mit_mapped_norm.fastq mit_mapped_norm.fq
ln -s ../../../../Data/$1/samples/$2/mit_mapped_norm.fastq2 mit_mapped_norm.fq2
ln -s ../../../../Data/AGAMB_MTgenome.fasta reference.fa

#Run Mira and MITObim
cp ../../../../Code/manifest.conf .
cp ../../../../Code/MITObim_1.8.pl .

sed -i "20s/.*/strain = $2/g" manifest.conf

mira manifest.conf &> mira_log

perl MITObim_1.8.pl -start 1 -end 20 -sample $2 -ref AGAM -readpool reads.fastq -maf initial-mapping_assembly/initial-mapping_d_results/initial-mapping_out.maf --paired --pair --clean --trimoverhang &> log

#Remove unnecesary files
rm reads.fastq mit_mapped_norm.fq mit_mapped_norm.fq2 manifest.conf reference.fa MITObim_1.8.pl
rm -r initial-mapping_assembly

ARR=($(ls -d -v -r iteration*))
rm -r ${ARR[1]}/
rm -r iteration*/*-AGAM_assembly/*-AGAM_d_tmp
rm -r iteration*/*-AGAM_assembly/*-AGAM_d_chkpt

cd ../
GZIP=-9 tar cvzf $2.tar.gz $2 && rm -r $2
cd ../../../

sleep 1

