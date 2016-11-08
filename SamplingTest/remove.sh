#!/bin/bash

#SBBATCH --time=00:20:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=remove
#SBATCH --mem=10Gb
#SBATCH --output=rem.log

#Description: Creates a table with summary statistics of the alignment and the assembly to compare their quality
#Written by: Jorge Eduardo Amaya Romero
#Last time revised: 14-10-2016

module load Biopython/1.65-foss-2016a-Python-2.7.11

mkdir -p Results/Remove/Data
mkdir -p Results/Remove/Results
cp -r Code/ Results/Remove/.
cp *.sh Results/Remove/.
cd Results/Remove

#(Refurbish: Link to the results of the previous step)
ln -s /path/to/SamplingTest/Results/Alignment/Results/* Data/.

python Code/control.py Data/seqs.afa $1
cp Results/Count_${1}.csv ../../Results/.

#(Refurbish: Type desired subsampling rates in order)
rate=(0.025 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1)

for i in "${!rate[@]}"; do
	if [[ ${rate[$i]} == ${1} ]];then
		name=${rate[$i+1]}
	fi
done
grep -v ",0" Results/Count_${1}.csv | cut -d "," -f 1 > ../../Data/names_${name}.csv
