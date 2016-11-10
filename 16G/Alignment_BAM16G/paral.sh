#!/bin/bash

#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=ali
#SBATCH --mem=50Gb

#Description: Obtain the assemblies and align the sequences to the reference
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

module purge
module load parallel/20160622-foss-2016a
module load MUSCLE/3.8.31-foss-2016a

for i in Results/*
        do
                cat ${i} >> Results/seqs.fasta
        done

muscle -in Results/seqs.fasta -out Results/seqs.afa
