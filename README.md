# Malaria Mitogenome  

##Description: 
A series of utilities to assemble and analyze mitochondrial genomes. Each directory has its own README.md file. Read it carefully before using the code.

##MITObim-based assembly utilities
* SamplingTest: Obtain adecuate sampling rates for your whole genome read file in sam file.
* 16G: Obtain adecuate sampling rates and assemble mitochondrial genomes of 79 malaria mosquitoes from bam and fastq files.
* 765G: Assemble mitochondrial genomes of 765 malaria mosquitoes from sam files.
* 844G: Combine the assemblies produced in 765G and 16G and align sequences.

##Check and edit alignments
* Fix\_and\_SubSet\_Align: Subset alignments and improve fasta headers.
* Control Removal: Compare the quality of the alignment with and without control region. Make a histogram to visualize the frequency and position of the insertions.

##Phylogenetics and population genetics analysis
* Jmodeltest: Evaluate and select the best subtitution models for subsequent phylogenetic analysis.
* Paup: Create NJ Tree using parameters recommended by Jmodeltest pipeline.
* NMDS: Perform and plot the NMDS scaling.
* Rarefaction: Perform rarefaction analysis per species and population.
* Plot\_Rarefaction: Plot the output of Rarefaction pipeline.

##Maps
* Map: Create a Map with populations marked with tacks.

##Clone this repository
Clone this repository and save yourself some time, do:

```
git clone git://github.com/jorgeamaya/Malaria/SamplingTest.git
```

##Disclaimer
Some of these scripts are general-purpose and you just have to worry about provinding correctly formated data, but others may need some reworking before you can apply them to your data (I created them to solve specific needs I had in mind.) I have placed copious amounts of comments to document where you most likely will have to change the code, but do not hesitate to contact me if you need assistance for that.

##Question, issues and bug reports:
To report bugs, please open an issue or send me and e-mail to:
* j.e.amaya.romero@student.rug.nl
* joreamayarom@unal.edu.co
