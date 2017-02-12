# Create a NJ tree using Paup 
Written by: Jorge Eduardo Amaya Romero

Read this whole file before using the script

##Description: 
Pipeline that creates a Maximum Likelihood trees using RAxML

##Pipelines and Scripts

1. raxml.sh: Produces the trees.
2. fasta\_to\_nexus.R: Converts multifasta file to nexus format 

##Usage:

```
sbatch master.sh
```
##Results

1. The alignments in Nexus format.
2. Results/\*.tre: A NJ tree in Nexus format.
3. paup\_report\*.txt: Paup output report.

##Additional Notes
You will need a running version of Paup in this directory. Adjust one of Code/execute\*.nexus files:
1. execute my\_alignment.nexus;
2. dset distance=GTR basefreq=empirical rates=gamma shape= pinv=; #Give appropriate shape= and pinv= to your model. You can obtain this paramaters running JmodelTest)
3. outgroup my\_outgroup;
4. savetrees file=my\_output.tre brlens format=altnexus; 

