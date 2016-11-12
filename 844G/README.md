# Find appropriate sampling rates for MITObim 
*Written by: Jorge Eduardo Amaya Romero*

Read this whole file before using the script

##Description: 
These scripts align 844 malaria mitochondrial genomes in an authomatic fashion. If you plan to refurbish these scripts to fit your needs, run 
```
grep "Refurbish" \*.sh
grep "Refurbish" Alignment/*.sh
```
in the main directory and you'll get a report of all the lines that must be edited. These scripts were desing to run on Slurm Version 16.05

##Scripts

1. master.sh: Extract the assemblies produced in 16G/
2. ali.sh: Extract the assemblies produduced in 765/
3. subordinate\*.sh: Extract the sequences and handle special directory structure

##Usage:

1. You will need ad Alignment/Data/names.csv file with the name of all you sequenes ina single column

To run the script just type:

```
sbatch master.sh
sbatch ali.sh
```

##Results

1. Alignment/Results/\*.fasta: Fasta file with each sequence.
2. Alignment/Results/seqs.fasta: Multifasta file with all your sequences.
3. Alignment/Results/seqs.afa: Multi fasta file with your alignment.
