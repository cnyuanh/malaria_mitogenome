#!/bin/bash

#SBATCH --time=00:01:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=sam
#SBATCH --mem=10000
#SBATCH --output=sam.log

#Description: Subset the assembly from the putative mitochondrial reads
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

module purge
module load SAMtools/1.3.1-foss-2016a
module load BEDTools/2.25.0-foss-2016a
module load parallel/20160622-foss-2016a
module load Python/2.7.11-foss-2016a
module load picard/1.130-Java-1.7.0_80 
module load Java/1.8.0_92

readarray individuals < Data/names_$1\.csv

mkdir -p Results/SAM_to_FASTQ/Data
mkdir -p Results/SAM_to_FASTQ/Results
cp -r Code/ Results/SAM_to_FASTQ/.
cp *.sh Results/SAM_to_FASTQ/.
cd Results/SAM_to_FASTQ

#Link the data sets (Refurbish: Change to path to the directory that contains your data)
ln -s /path/to/Sequences/* Data/.

jobids=()
for i in ${individuals[@]}
	do
		cmd="sbatch subordinate_sam.sh $i $1"
		jobids+=(`$cmd | cut -d ' ' -f 4`)
	done

txt=$(printf ":%s" "${jobids[@]}")
txt=${txt:1}

cd ../../

#Call the next script as a dependency
sbatch --dependency=afterok:$txt ass.sh $1 | cut -d ' ' -f 4
