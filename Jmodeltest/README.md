#!/bin/bash

#Description: Run classic jmodeltest analysis (88 models - 4 categories, test AIC and BIC and obtaing a phylogeny (-a))
#Author: Jorge Eduardo Amaya Romero
#Date:16-10-2016

##Description: 
Calculate the best subsitution model for an alignment.

##Pipelines and Scripts

1. ./master.sh: Produces the plots.

##Usage:

```
nohup java -jar jmodeltest-2.1.10/jModelTest.jar -d alignment.fasta -g 4 -i -f -AIC -BIC -a &
```

##Results
1. nohup.out: A file jmodeltest-2.1.10 output

##Additional notes
A running version of jmodeltest-2.1.10 in this directory.

