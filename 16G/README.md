# Find appropriate sampling rates for MITObim 
*Written by: Jorge Eduardo Amaya Romero*

Read this whole file before using the script

##Description: 
These scripts subsample and assemble 16G malaria mitochondrial genomes in an authomatic fashion. It can be used to find the best subsampling rates as well as obtain the definite assembly. If you plan to refurbish these scripts to fit your needs, run 
```
grep "Refurbish" \*.sh
```
on the main directory of each pipeline and you'll get a report of all the lines that must be edited. This scripts were desing to run on Slurm Version 16.05

##Pipelines and Scripts

1. BAM\_to\_FASTQ\_16G: Performs the subsampling.
2. Assembly\_BAM16G: Performs the assembly.
3. Alignment\_BAM16G: Aligns the assemblies.
4. remove.sh: Reports wich sequences produces assemblies of good quality and which sequences must be realigned at a higher rate.
5. quality.sh: Check if there are assemblies with more than an arbitrary threshold of ambiguities.
6. clean.sh: Cleans the Results directory and leaves the directory ready to test another sampling rate.

##Usage:
Since running these scripts can produce big intermediate files, it is not recommended to execute them all at once. Run

```
sbatch master.sh Data/annotations.csv #(See more info on Data/annotations.csv)
```
in BAM\_to\_FASTQ\_16G, Assembly\_BAM16G (in that order) and 

```
sbatch master.sh
sbatch paral.sh
```
in Alignment\_BAM16G.

After obtaining the alignment check the quality of the assemblies with:

```
sbatch remove.sh
sbatch clean.sh
```
If the asemblies have passing quality, use Results/Scores.csv to create a new Data/annotation.csv with your definitive sampling rates. If the assemblies do not have passing quality, make a new annotations.csv file using names\_${rate}.csv file found in Data/. I have included small sample files for these three \*.csv

##Results

1. Results/BAM\_to\_FASTQ16G: A directory with data set subsampled at rates recommended in SamplingTest.
2. Results/Assembly16G: A directory with the assembled genomes.
3. Results/Alignment\_BAM16G: A directory with the assembled.

##Additional Notes
1. These scripts force the IUPAC concensus in ambiguous calls. To do so, flag fnicpst=yes has been included in the parameters of manifest.conf as well in MITObim.pl. To verify the line type:

```
grep -in "#Modified\_Line" Assembly16G/Code/MITObim\_1.8.pl
```

2. Data/annotations.csv is a csv file of the species, the name of the sample, and the recommended sampling rate (create this file manually) using names\_${rate} found in Data. 

```
Arabiensis,SRS408146,0.1,
```

3. Decide the sampling rates and in which order you want to subsample your data. The default is

```
rate=(0.025 0.1 0.2 0.3 1).
```
4. Scripts ended in \_himem run in high memory nodes (recommended when files are big).

##Reference
Integrated to this pipeline are the scripts of other people:

* [picard](https://github.com/broadinstitute/picard)
* [MITObim](https://github.com/chrishah/MITObim)
