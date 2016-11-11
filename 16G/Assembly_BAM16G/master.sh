#!/bin/bash

#SBATCH --time=00:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --job-name=ass
#SBATCH --mem=100

#Description: assemble the mitochondrial genomes 
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
#ln -s /path/to/Sequences/reference/AGAMB_MTgenome.fasta Data/.
#ln -s /path/to/16G/BAM_to_FASTQ_16G/Results/* Data/.

MIRA=(C27.2 M20.7 45.3 C27.3  44.4  A7.4 40.2  44.2)
MITO=(4631 4700 5090 5091 TZ22 4697 4701 5108  5109  TZ65  4691  4696  5093  5107  TZ67  4634  4698  5095  5113  TZ102)

while IFS='' read -r line || [[ -n "$line" ]]; do
        IFS=',' read -ra VAR  <<< "$line"
        spe=${VAR[0]}
        sample="${VAR[1]}"
	if [ ${spe} == "Arabiensis" ];  then 
		echo "Data/16G_arabiensis/samples/${sample} Rate"
		sbatch subordinate.sh "16G_arabiensis" ${sample}
	elif [ ${spe} == "Merus" ]; then
               echo "Data/16G_merus/samples/${sample} Rate"
		sbatch subordinate.sh "16G_merus" ${sample} 
	elif [ ${spe} == "Melas" ]; then
                echo "Data/16G_melas/samples/${sample} Rate"
		sbatch subordinate.sh "16G_melas" ${sample} 
	elif [ ${spe} == "Quadriannulatus" ]; then
                echo "Data/16G_quadriannulatus/samples/${sample} Rate"
		sbatch subordinate.sh "16G_quadriannulatus" ${sample}
	elif [ ${spe} == "Bamako" ]; then
	        echo "Data/16G_bamako/samples/${sample} Rate"
                sbatch subordinate.sh "16G_bamako" ${sample}
	elif [ ${spe} == "Epiroticus" ]; then
		echo "Data/16G_epiroticus/samples/${sample} Rate"
		sbatch subordinate.sh "16G_epiroticus" ${sample}
	elif [ ${spe} == "Christyi" ]; then
		echo "Data/16G_christyi/samples/${sample} Rate"
		sbatch subordinate.sh "16G_christyi" ${sample}
	elif [ ${spe} == "Gambiae_ND1" ]; then
		echo "Data/16G_gambiae/samples/ND1/${sample} Rate"
		if [[ ${MIRA[*]} =~ $sample ]]; then  
			echo "MIRA Data/16G_gambiae/samples/ND1/${sample} Rate"
			sbatch subordinateND_MIRA.sh "16G_gambiae" "ND1" ${sample} 
		else 
			echo "MITO Data/16G_gambiae/samples/ND1/${sample} Rate"
			sbatch subordinateND_MITO.sh "16G_gambiae" "ND1" ${sample} 
		fi
	elif [ ${spe} == "Gambiae_ND2" ]; then
		echo "Data/16G_gambiae/samples/ND2/${sample} Rate"
		if [[ ${MIRA[*]} =~ $sample ]]; then  
			echo "MIRA Data/16G_gambiae/samples/ND2/${sample} Rate"
			sbatch subordinateND_MIRA.sh "16G_gambiae" "ND2" ${sample} 
		else 
			echo "MITO Data/16G_gambiae/samples/ND2/${sample} Rate"
			sbatch subordinateND_MITO.sh "16G_gambiae" "ND2" ${sample}
		fi
	elif [ ${spe} == "Gambiae_ND3" ]; then
		echo "Data/16G_gambiae/samples/ND3/${sample} Rate"
		if [[ ${MIRA[*]} =~ $sample ]]; then  
			echo "MIRA Data/16G_gambiae/samples/ND3/${sample} Rate" 
			sbatch subordinateND_MIRA.sh "16G_gambiae" "ND3" ${sample} 
		else 
			echo "MITO Data/16G_gambiae/samples/ND3/${sample} Rate"
			sbatch subordinateND_MITO.sh "16G_gambiae" "ND3" ${sample}
		fi
	elif [ ${spe} == "Gambiae_ND4" ]; then
		echo "Data/16G_gambiae/samples/ND4/${sample} Rate"
		if [[ ${MIRA[*]} =~ $sample ]]; then  
			echo "MIRA Data/16G_gambiae/samples/ND4/${sample} Rate"
			sbatch subordinateND_MIRA.sh "16G_gambiae" "ND4" ${sample}
		else 
			echo "MITO Data/16G_gambiae/samples/ND4/${sample} Rate"
			sbatch subordinateND_MITO.sh "16G_gambiae" "ND4" ${sample}
		fi
	else
       	        echo "Data/16G_bwambae/samples/${sample} Rate"
		sbatch subordinate.sh "16G_bwambae" ${sample}
	fi
done < "$1"

