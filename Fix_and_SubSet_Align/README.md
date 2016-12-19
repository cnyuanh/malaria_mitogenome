# Fix and add information to the fasta headers
Written by: Jorge Eduardo Amaya Romero
Last revision: 15-10-2016
Status: Completed

## Description: 
This script standarizes the fasta headers. The format of the new fasta header is:

```
>Sample\_Id [ Species Population Country Region/Town Latitude Longitude Year ]
```

Information between brackets is contained in a separate csv file that can be feed to the program.

## Input

1. An alignment in fasta format
2. A csv file with info of each of your sequences (see the structure of header above.)

## Results

1. seqs\_844G\_no\_gaps\_no\_reference.fasta: The same original alignment with improved fasta headers.
2. seqs\_16Gproject\_no\_gaps\_no\_reference.fasta: Subset of 1 including only the sequences of Fontaine et. al. (2015) + Bwambae
3. seqs\_765Gproject\_no\_gaps\_no\_reference.fasta: Subset of 1 including only the sequences of MalariaGEN + 2 Outgroups

## Usage

1. sbatch script.sh

## Note: 
I tailored this script specifically for my needs. If you want to use it:

1. Be sure that the sequences' ID match the one in the csv file. Consider using sed to clean your fasta headers (as I did in script.sh)
