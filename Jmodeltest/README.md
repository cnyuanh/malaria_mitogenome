#Obtain substitution model for multifasta alignments
Written by: Jorge Eduardo Amaya Romero

##Description: 
Run classic jmodeltest analysis (88 models - 4 categories, test AIC and BIC) on a series of multifasta files.
##Date:
16-10-2016

##Data: 
A series of alignments in fasta format

##Results: 
*.jrun files with the output of Jmodeltest2

##Usage
```
nohup ./run_jmodel.sh &
```

##Note:
* To run this script, a working version of jmodeltest is needed in the main directory.
* Data/Outgroup_Mitobim contains files in which the outgroups were assembled with Mitobim.
