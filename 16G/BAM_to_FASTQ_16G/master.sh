#!/bin/bash

#SBATCH --time=00:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --job-name=bam.log
#SBATCH --mem=100

#Description: Subset the *.fastq.gz files
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

module purge
module load SAMtools/1.3.1-foss-2016a
module load BEDTools/2.25.0-foss-2016a
module load parallel/20160622-foss-2016a
module load Python/2.7.11-foss-2016a
module load picard/1.130-Java-1.7.0_80 
module load Java/1.8.0_92

#Link the data sets (Refurbish: Change to path to the directory that contains your data)
ln -s /path/to/samples/* Data/.

#Files per assembly method
MIRA=(C27.2 M20.7 45.3 C27.3  44.4  A7.4 40.2  44.2)
MITO=(4631 4700 5090 5091 TZ22 4697 4701 5108  5109  TZ65  4691  4696  5093  5107  TZ67  4634  4698  5095  5113  TZ102)

while IFS='' read -r line || [[ -n "$line" ]]; do

        IFS=',' read -ra VAR  <<< "$line"
        spe=${VAR[0]}
        sample="${VAR[1]}"
        rate="${VAR[2]}"
	if [ ${spe} == "Arabiensis" ];  then 
		echo "Data/16G_arabiensis/samples/${sample} Rate ${rate}"
		sbatch subordinate.sh "16G_arabiensis" ${sample} ${rate}
	elif [ ${spe} == "Merus" ]; then
                echo "Data/16G_merus/samples/${sample} Rate ${rate}"
		sbatch subordinate.sh "16G_merus" ${sample} ${rate}
	elif [ ${spe} == "Melas" ]; then
                echo "Data/16G_melas/samples/${sample} Rate ${rate}"
		sbatch subordinate.sh "16G_melas" ${sample} ${rate}
	elif [ ${spe} == "Quadriannulatus" ]; then
                echo "Data/16G_quadriannulatus/samples/${sample} Rate ${rate}"
		sbatch subordinate.sh "16G_quadriannulatus" ${sample} ${rate}
	elif [ ${spe} == "Bamako" ]; then
	        echo "Data/16G_bamako/samples/${sample} Rate ${rate}"
		if [ ${sample} == "KL0829" ]; then
			sbatch subordinate.sh "16G_bamako" ${sample} ${rate}
		else
			sbatch subordinate.sh "16G_bamako" ${sample} ${rate}
		fi
	elif [ ${spe} == "Epiroticus" ]; then
		echo "Data/16G_epiroticus/samples/${sample} Rate ${rate}"
		sbatch subordinate_epi_chr.sh "16G_epiroticus" ${sample} ${rate}
	elif [ ${spe} == "Christyi" ]; then
		echo "Data/16G_christyi/samples/${sample} Rate ${rate}"
		sbatch subordinate_epi_chr.sh "16G_christyi" ${sample} ${rate}
	elif [ ${spe} == "Gambiae_ND1" ]; then
		echo "Data/16G_gambiae/samples/ND1/${sample} Rate"
		if [[ ${MIRA[*]} =~ $sample ]]; then  
			echo "MIRA Data/16G_gambiae/samples/ND1/${sample} Rate"
			sbatch subordinateND.sh "16G_gambiae" "ND1" ${sample} 
		else 
			echo "MITO Data/16G_gambiae/samples/ND1/${sample} Rate"
			sbatch subordinateND.sh "16G_gambiae" "ND1" ${sample} ${rate} 
		fi
	elif [ ${spe} == "Gambiae_ND2" ]; then
		echo "Data/16G_gambiae/samples/ND2/${sample} Rate"
		if [[ ${MIRA[*]} =~ $sample ]]; then  
			echo "MIRA Data/16G_gambiae/samples/ND2/${sample} Rate"
			sbatch subordinateND.sh "16G_gambiae" "ND2" ${sample} 
		else 
			echo "MITO Data/16G_gambiae/samples/ND2/${sample} Rate"
			sbatch subordinateND.sh "16G_gambiae" "ND2" ${sample} ${rate}
		fi
	elif [ ${spe} == "Gambiae_ND3" ]; then
		echo "Data/16G_gambiae/samples/ND3/${sample} Rate"
		if [[ ${MIRA[*]} =~ $sample ]]; then  
			echo "MIRA Data/16G_gambiae/samples/ND3/${sample} Rate" 
			sbatch subordinate.sh "16G_gambiae" "ND3" ${sample} 
		else 
			echo "MITO Data/16G_gambiae/samples/ND3/${sample} Rate"
			sbatch subordinateND.sh "16G_gambiae" "ND3" ${sample} ${rate}
		fi
	elif [ ${spe} == "Gambiae_ND4" ]; then
		echo "Data/16G_gambiae/samples/ND4/${sample} Rate"
		if [[ ${MIRA[*]} =~ $sample ]]; then  
			echo "MIRA Data/16G_gambiae/samples/ND4/${sample} Rate"
			sbatch subordinateND.sh "16G_gambiae" "ND4" ${sample}
		else 
			echo "MITO Data/16G_gambiae/samples/ND4/${sample} Rate"
			sbatch subordinateND.sh "16G_gambiae" "ND4" ${sample} ${rate}
		fi
	else
       	        echo "Data/16G_bwambae/samples/${sample} Rate ${rate}"
		sbatch subordinate.sh "16G_bwambae" ${sample} ${rate}
	fi
done < "$1"

