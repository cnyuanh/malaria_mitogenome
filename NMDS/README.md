# Calculate and plot NMDS
Written by: Jorge Eduardo Amaya Romero
Last revision: 15-12-2016
Status: Completed

## Description: 
Create MDSM plots by Species and Population.

## Input

1. A csv file with pairwise distances. You can produce this file with MEGA. Be sure to select "," as separator when exporting the file.
2. A csv file with the ID and categories you want to use in your analysis. I used:

```
Sampĺe\_ID,Species,Population
AN0000_C,An.gambiae,AOM
AN0001_C,An.coluzzii,CMM 
```

## Results

1. Results/\*.pdf: Plots with the results of the PCA.
2. Results/Scores.Rda: NMDS calculations can take long. This file saves your old calculations. You can uncomment the "load" line in Code/plot.Rto resume the script.

## Usage

1. sbatch script.sh

## Note: 
I tailored this pipeline specifically for my needs. If you want to use it:

1. In Code/plot.R, be sure to remove your outgroup (if you want) from species, names and mat. You will need to know the position of your outgroup. (Check how I did it in the script. My outgroup are the first and second IDs)
2. Fix the colors and shapes as you please in Code/plot.R
