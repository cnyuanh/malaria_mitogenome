# Find appropriate sampling rates for MITObim 
*Written by: Jorge Eduardo Amaya Romero*

Read this whole file before using the script

##Description: 
These scripts subsample and assemble 765 malaria mitochondrial genomes in an authomatic fashion. If you plan to refurbish these scripts to fit your needs, run 
```
grep "Refurbish" \*.sh
grep "Refurbish" Code/control.py
```
in the main directory and you'll get a report of all the lines that must be edited. This scripts were desing to run on Slurm Version 16.05

##Scripts

1. sam.sh and subordinate\_sam.sh: Subsample the data sets.
2. ass.sh and subordinate\_ass.sh: Perform the assemblies. 

##Usage:

Some caveats before running the script:
1. Each sample must have its own directory. This is what is going to be simbolically linked in sam.sh.

To run the script just type:

```
sbatch sam.sh
```

##Results

1. Results/SAM\_to\_FASTQ: A directory with data set subsampled at rates recommended in SamplingTest.
2. Results/Assembly: A directory with the assembled genomes.

##Additional Notes
1. These scripts force the IUPAC concensus in ambiguous calls. To do so, flad fnicpst=yes has been included in the parameters of manifest.conf as well in MITObim.pl. To verify the line type:

```
grep -in "#Modified_Line" Code/MITObim_1.8.pl
```

##Reference
Integrated to this pipeline are the scripts of other people:

* [picard](https://github.com/broadinstitute/picard)
* [MITObim](https://github.com/chrishah/MITObim)
