#!/bin/bash

#SBATCH --time=00:01:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=ass
#SBATCH --mem=10000
#SBATCH --output=ass.log

#Description: Assemble the mitochondrial genomes based on putative mitochondrial reads
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

module purge
module load Perl/5.22.1-foss-2016a
module load Python/3.5.1-intel-2016a
module load parallel/20160622-foss-2016a
module load MIRA/4.0.2-foss-2016a-Python-2.7.11

ids=( $( cut -d ',' -f1 Data/Scores.csv) )

mkdir -p Results/Assembly/Data
mkdir -p Results/Assembly/Results
cp -r Code Results/Assembly/.
cp *.sh Results/Assembly/.
cd Results/Assembly

#Link the data sets (Refurbish: Change the path to the directory that contains the results and your reference)
ln -s /path/to/765G/Results/SAM_to_FASTQ/Results/* Data/.
ln -s /path/to/Sequences/reference/AGAMB_MTgenome.fasta Data/.

len=${#ids[@]}

jobids=()
for (( i = 0; i <${len}; i++))
        do
		cmd="sbatch subordinate_ass.sh ${ids[$i]}"
                jobids+=(`$cmd | cut -d ' ' -f 4`)
        done

txt=$(printf ":%s" "${jobids[@]}")
txt=${txt:1}

cd ../../
