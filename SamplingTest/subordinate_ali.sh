#!/bin/bash

#Description: Obtain the last assembly with all IUPAC ambiguities
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

cd Results
tar -xzvf ../Data/$1\.tar.gz $1/iteration*/$1-AGAM_assembly/$1-AGAM_d_results/$1-AGAM_out_$1\.unpadded.fasta
mv $1/iteration*/$1-AGAM_assembly/$1-AGAM_d_results/$1-AGAM_out_$1\.unpadded.fasta .
rm -r $1 
sed "s/^\(>.*\)$/>$1/" $1-AGAM_out_$1\.unpadded.fasta > $1\.fasta
rm $1-AGAM_out_$1\.unpadded.fasta
cd ../
