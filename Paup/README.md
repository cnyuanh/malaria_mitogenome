# Create a NJ tree using Paup 
Written by: Jorge Eduardo Amaya Romero

Read this whole file before using the script

##Description: 
Pipeline that creates a NJ tree using Paup

```
grep "Refurbish" \*.nexus
grep "Refurbish" \*.R
```

##Pipelines and Scripts

1. master.sh: Produces the trees.
2. fasta\_to\_nexus.R: Converts multifasta file to nexus format 

##Usage:

```
sbatch master.sh
```
##Results

1. The alignment in Nexus format.
2. \*.tre: A NJ tree in Nexus format.
3. paup\_report.txt: Paup output report.

##Additional Notes
1. You will need a running version of Paup in this directory and adjust the master script.
