#!/bin/bash

#Description: Run RAxML analysis. Use Epiroticus as outgroup.
#Author: Jorge Eduardo Amaya Romero
#Date:10-10-2016
#Comment: Move manually your results to the designated directiores in Results

#ln -s /home/jorgeromero/PhyTree/Fix_and_SubSet_Align/Results/*.fasta Data/.

#Run RAxML on Fontaine et. al. (2015) + Bwambae
./standard-RAxML-master/raxmlHPC-PTHREADS-AVX -T 12 -f a -x 12345 -p 12345 -# 10000 -m GTRGAMMA -s Data/seqs_16Gproject_no_gaps_no_reference.fasta -o SRS228219 -n seqs_16Gproject_no_gaps_no_reference.fasta.tree.raxml > seqs_16Gproject_no_gaps_no_reference.fasta.tree.screen.txt &
./standard-RAxML-master/raxmlHPC-PTHREADS-AVX -T 12 -f b -t RAxML_bestTree.seqs_16Gproject_no_gaps_no_reference.fasta.tree.raxml -z RAxML_bootstrap.seqs_16Gproject_no_gaps_no_reference.fasta.tree.raxml -m GTRGAMMA -s Data/seqs_16Gproject_no_gaps_no_reference.fasta -o SRS228219 -n seqs_16Gproject_no_gaps_no_reference.fasta.BOOTTREE.raxml &

./standard-RAxML-master/raxmlHPC-PTHREADS-AVX -T 12 -f a -x 12345 -p 12345 -# 10000 -m GTRGAMMA -s Data/seqs_765Gproject_no_gaps_no_reference.fasta -o SRS228219 -n seqs_765Gproject_no_gaps_no_reference.fasta.tree.raxml > seqs_765Gproject_no_gaps_no_reference.fasta.tree.screen.txt &
./standard-RAxML-master/raxmlHPC-PTHREADS-AVX -T 12 -f b -t RAxML_bestTree.seqs_765Gproject_no_gaps_no_reference.fasta.tree.raxml -z RAxML_bootstrap.seqs_765Gproject_no_gaps_no_reference.fasta.tree.raxml -m GTRGAMMA -s Data/seqs_765Gproject_no_gaps_no_reference.fasta -o SRS228219 -n seqs_765Gproject_no_gaps_no_reference.fasta.BOOTTREE.raxml &

./standard-RAxML-master/raxmlHPC-PTHREADS-AVX -T 12 -f a -x 12345 -p 12345 -# 10000 -m GTRGAMMA -s Data/seqs_844G_no_gaps_no_reference.fasta -o SRS228219 -n seqs_844G_no_gaps_no_reference.fasta.tree.raxml > seqs_844G_no_gaps_no_reference.fasta.tree.screen.txt &
./standard-RAxML-master/raxmlHPC-PTHREADS-AVX -T 12 -f b -t RAxML_bestTree.seqs_844G_no_gaps_no_reference.fasta.tree.raxml -z RAxML_bootstrap.seqs_844G_no_gaps_no_reference.fasta.tree.raxml -m GTRGAMMA -s Data/seqs_844G_no_gaps_no_reference.fasta -o SRS228219 -n seqs_844G_no_gaps_no_reference.fasta.BOOTTREE.raxml &
