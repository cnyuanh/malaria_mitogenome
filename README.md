# Utilities to assemble and analyze Mitochondrial genomes 

##Description: 
A series of utilities and scripts to assemble and analyze mitochondrial genomes. Each directory has its own README.md file, read it carefully before using the code.

* SamplingTest: Obtain addecaute sampling rates for your dataset.
* 765G: Assemble mitochondrial genomes of 765 malaria mosquitoes from sam files.
* 16G: Assemble mitochondrial genomes of 75 malaria mosquitoes from bam files.
* 844G: Combine the assemblies produced in 765G and 16G and align sequences.
* Map: Creates a Map with populations marked with tacks.
* Control Removal: Creates a series o plots showing the quality of the alignment with and without control region and a extra histogram with the frequency of per position in the concensus.
* Jmodeltest: Evaluates and selectes the best subtitution models 
* Paup: Creates NJ Tree using parameters recommended by Jmodeltest.

##Clone this repository
You should be able to clone this repository and start working immediately, just do:

```
git clone git://github.com/jorgeamaya/Malaria/SamplingTest.git
```

##Bug report
To report bugs, please open an issue or send and e-mail to:
* j.e.amaya.romero@student.rug.nl
* joreamayarom@unal.edu.co
