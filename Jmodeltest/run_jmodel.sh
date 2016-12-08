#!/bin/bash

#Description: Run classic jmodeltest analysis (88 models - 4 categories, test AIC and BIC and obtaing a phylogeny (-a))
#Author: Jorge Eduardo Amaya Romero
#Date:10-10-2016

ln -s /home/jorgeromero/PhyTree/Fix_and_SubSet_Align/Results/*.fasta Data/.

for file in Data/*
	do
	d=${file%%.fasta}	
	echo ${d##*/}
	java -jar jmodeltest-2.1.10/jModelTest.jar -d ${file} -g 4 -i -f -AIC -BIC -a &> Results/${d##*/}.jrun
	done

