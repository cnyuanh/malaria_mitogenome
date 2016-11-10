#!/bin/bash

#SBATCH --time=1-23:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --job-name=assMIRA%j.log
#SBATCH --mem=500GB
#SBATCH --partition=himem

#Description: Performs the assembly
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016
#Note: Deal with special names of ND gambiae

module purge
module load Perl/5.22.1-foss-2016a
module load Python/3.5.1-intel-2016a
module load parallel/20160622-foss-2016a
module load MIRA/4.0.2-foss-2016a-Python-2.7.11

echo "Data/$1/samples/$2"

mkdir -p Results/$1/samples/$2/$3
cd Results/$1/samples/$2/$3

#Link necessary files
ln -s ../../../../../Data/$1/samples/$2/$3/interleaved.fastq reads.fastq 
ln -s ../../../../../Data/$1/samples/$2/$3/mit_mapped_norm.fastq mit_mapped_norm.fq
ln -s ../../../../../Data/$1/samples/$2/$3/mit_mapped_norm.fastq2 mit_mapped_norm.fq2
ln -s ../../../../../Data/AGAMB_MTgenome.fasta reference.fa

#Run Mira and MITObim
cp ../../../../../Code/manifest.conf .
cp ../../../../../Code/MITObim_1.8.pl .

sed -i "20s/.*/strain = $3/g" manifest.conf

mira manifest.conf &> mira_log

#Remove unnecesary files
rm reads.fastq mit_mapped_norm.fq mit_mapped_norm.fq2 manifest.conf reference.fa MITObim_1.8.pl
rm -r initial-mapping_assembly/initial-mapping_d_tmp/
rm -r initial-mapping_assembly/initial-mapping_d_chkpt/

cd ../
GZIP=-9 tar cvzf $3.tar.gz $3 && rm -r $3
cd ../../../../

sleep 1

