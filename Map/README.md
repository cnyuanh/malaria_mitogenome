# Find appropriate sampling rates for MITObim 
*Written by: Jorge Eduardo Amaya Romero*

Read this whole file before using the script

##Description: 
Function to create map. Ideal to visualize many populations at the same time. Population are marked with tacks. The size of the head is equivalent to population size.

##Pipelines and Scripts

1. ./master.sh: Produces the plots.

##Usage:

```
sbatch master.sh
```
##Results

1. map.png: Stand alone map
2. map1.png: Map for data set 1.
3. map2.png: Map for data set 2.
4. map\_final.png: All populations in the same map.

##Additional Notes
You will need a Location.csv file with following columns: 
```
population,latitude,longitude,freq,latitude\_end,longitude\_end,source
```
* population: Species or variaety.
* latitude and longited: position where the sample was taken.
* freq: number of samples.
* latitude\_end and longitude\_end: Position of the head of the tack.
* source: data\_set

