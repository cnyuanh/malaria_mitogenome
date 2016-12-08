#!/bin/bash

module load Biopython/1.65-foss-2016a-Python-2.7.11
#(Refurbish: Cahgne this line to point to your aligment)
cp /data/s3017141/Malaria_MitoGenome/Def_Assembly/malaria_mitogenome/Clean_Alignments/seqs_844G_no_gaps_no_reference.fasta Data/.
ln -s /data/s3017141/Malaria_MitoGenome/Def_Assembly/malaria_mitogenome/Clean_Alignments/panoptes.csv Data/.
#Clean the fasta header so it fits the columnd in Data/panoptes.csv
sed -i 's/^\(>16G_[a-z]*_\)\(.*$\)/>\2/' Data/seqs_844G_no_gaps_no_reference.fasta 
sed -i 's/^\(>ND[0-9]_\)\(.*$\)/>\2/' Data/seqs_844G_no_gaps_no_reference.fasta
python Code/rename_fasta.py Data/panoptes.csv seqs_844G_no_gaps_no_reference.fasta seqs_16Gproject_no_gaps_no_reference.fasta seqs_765Gproject_no_gaps_no_reference.fasta

