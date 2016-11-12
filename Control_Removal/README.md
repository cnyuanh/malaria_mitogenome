# Quality of the assembly with and without control region
Written by: Jorge Eduardo Amaya Romero
Last revision: 15-10-2016
Status: Completed

## Description: 
The scripts in this directory create a series of tables and plots to compare the quality of the alignments with and without control region for further analysis. Remove the control region using your own script or a program like Geneious.

## Additional notes and mode of execution:

Be sure to change the name of your reference, and files in script.sh

Execution

	sbatch script.sh

## Results
1. gap\_stats.csv. Table with information about the position of the gaps.
2. statsg.csv. Table with properties of the alignment with control region.
3. statsf.csv. Table with properties of the alignment without control region.
4. \*.png. Plots with that summarize the information the previous tables.
