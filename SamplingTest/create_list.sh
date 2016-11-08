#!/bin/bash

#rate=(0.025 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1)
rate=(0.025 0.05 0.1)

d=0
for i in "${rate[@]}"
	do
		d=$((d + 1))
		readarray individual_${d} < Data/names_$i\.csv
	done

echo ${individual_1[@]} ${individuals_2[@]} | tr ' ' '\n' | sort | uniq -u
