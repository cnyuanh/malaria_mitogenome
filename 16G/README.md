# Find appropriate sampling rates for MITObim 
*Written by: Jorge Eduardo Amaya Romero*

Read this whole file before using the script

##Description: 
These scripts subsample and assemble 16G malaria mitochondrial genomes in an authomatic fashion. If you plan to refurbish these scripts to fit your needs, run 
```
grep "Refurbish" \*.sh
```
on the main directory of each pipeline and you'll get a report of all the lines that must be edited. This scripts were desing to run on Slurm Version 16.05

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

##Results

1. Results/BAM\_to\_FASTQ16G: A directory with data set subsampled at rates recommended in SamplingTest.
2. Results/Assembly16G: A directory with the assembled genomes.
3. Results/Alignment\_BAM16G: A directory with the assembled.

##Additional Notes
1. These scripts force the IUPAC concensus in ambiguous calls. To do so, flag fnicpst=yes has been included in the parameters of manifest.conf as well in MITObim.pl. To verify the line type:

```
grep -in "#Modified_Line" Assembly16G/Code/MITObim_1.8.pl
```

2. Data/annotations.csv is a csv file of the species, the name of the sample, and the recommended sampling rate:

```
Arabiensis,SRS408146,0.1,
```

##Reference
Integrated to this pipeline are the scripts of other people:

* [picard](https://github.com/broadinstitute/picard)
* [MITObim](https://github.com/chrishah/MITObim)
