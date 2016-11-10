# Find appropriate sampling rates for MITObim 
*Written by: Jorge Eduardo Amaya Romero*

Read this whole file before using the script

##Description: 
Since MITObim requires appropriate sampling rates to produce nice results, these scripts subsample, assemble, align, evaluate and report the quality of the assemblies for 765 malaria mitochondrial genomes in an authomatic fashion. If you plan to refurbish these script to fit your needs, run 
```
grep "Refurbish" \*.sh
grep "Refurbish" Code/control.py
```
in the main directory and you'll get a report of all the lines that must be edited. This scripts were desing to run on Slurm Version 16.05

##Clone this repository
You should be able to clone this repository and start working immediately, just do:

```
git clone git://github.com/jorgeamaya/Malaria/SamplingTest.git
```

##Scripts

1. sam.sh and subordinate\_sam.sh: Subsample the data sets.
2. ass.sh and subordinate\_ass.sh: Perform the assemblies. 
3. ali.sh and subordinate\_ali.sh: Aligns the sequences.
4. remove.sh: Reports wich sequences produces assemblies of good quality and which sequences must be realigned at a higher rate.
5. clean.sh: Cleans the Results directory.
6. quality.sh: Check if there are assemblies with more than an arbitrary threshold of ambiguities.

##Usage:

Some caveats before running the script:
1. Each sample must have its own directory. This is what is going to be simbolically linked in sam.sh.
2. Decide the sampling rates and in which order you want to subsample your data. The default is 

```
rate=(0.025 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1). 
```

If you want to change this, edit the appropiate line in remove.sh with your desired order (see below why.)
3. To start, you need a file /Data/names\_0.025.csv with the name of ALL your samples in a single column. The number at the end is your first subsampling rate. Again, if you want to start with a different rate, change the name of the file appropiately.

To run the script just type:

```
rate=0.025 #The sampling rate with which you want to start.
sbatch sam.sh $rate
```

##Results

1. Results/Count\_0.025.csv: A file with the number of ambiguities found in each sequence for that particular sampling rate after removing the control sequence.
2. Results/seqs\_0.025.afa: A file with the alignment for assemblies produced for that sampling rate.
3. Data/names\_0.5.csv: A file with the assemblies that had at least 1 ambiguitie when assembled at rate 0.025 and that you must assemble at a higher rate (This is the reason why you have to provide the appropriate order for your sampling rates).

##Additional Notes
Since it can be almost impossible to produce assemblies without a single ambiguity, my recommendation to stop once quality.sh returns a positive message. After performing the assemblies, you can check that with:

```
./quality.sh
```

If the results is negative, you can run the process again at a higher rate

```
rate=0.05
sbatch sam.sh $rate
```

##Reference
Integrated to this pipeline are the scripts of other people:

* [picard](https://github.com/broadinstitute/picard)
* [MITObim](https://github.com/chrishah/MITObim)
