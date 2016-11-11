#!/bin/bash

#SBATCH --time=00:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --job-name=ali
#SBATCH --mem=1000

#Description: Obtain the assemblies and align the sequences to the reference
#Written by: Jorge Eduardo Amaya Romero
#Last revision: 14-10-2016

module purge
module load Perl/5.22.1-foss-2016a
module load Python/3.5.1-intel-2016a
module load parallel/20160622-foss-2016a
module load MIRA/4.0.2-foss-2016a-Python-2.7.11

(#Refurbish: Modify this line to point to your data)
#ln -s /path/to/16G/Assembly_BAM16G/Results/* Data/.
#cp /path/to/reference/AGAMB_MTgenome.fasta Results/seqs.fasta #Create the multifasta file and put the reference

#The structure of the directories is not regular. Make a list of all the directories that are going to reviewed.
species=(16G_arabiensis 16G_melas 16G_quadriannulatus 16G_bamako 16G_gambiae 16G_merus 16G_epiroticus 16G_christyi)

arabiensis=(SRS408146 SRS408154 SRS408970 SRS408985 SRS408989 SRS408991 SRS408148 SRS408183 SRS408984 SRS408987 SRS408990 SRS408993)
melas=(SRS408142 SRS408147 SRS408185 SRS408994)
quadriannulatus=(SRS408143 SRS408145 SRS408151 SRS408155 SRS408966 SRS408969 SRS408972 SRS408973 SRS408983 SRS420578)
bamako=(KL0218 KL0231 KL0341 KL0671 KL0899 KL0028 KL0220 KL0333 KL0370 KL0829)
gambiae=(ND1_MIRA ND2_MIRA ND3_MIRA ND4_MIRA ND1_MITO ND2_MITO ND3_MITO ND4_MITO)
ND1_MIRA=(C27.2  M20.7) #Assembled with method MIRA
ND2_MIRA=(45.3  C27.3)
ND3_MIRA=(44.4  A7.4)
ND4_MIRA=(40.2  44.2)
ND1_MITO=(4631  4700  5090  5091  TZ22) #Assembled with method Samtools_MITObim
ND2_MITO=(4697  4701  5108  5109  TZ65)
ND3_MITO=(4691  4696  5093  5107  TZ67)
ND4_MITO=(4634  4698  5095  5113  TZ102)
merus=(SRS408186 SRS408187 SRS408967 SRS408974 SRS408992 SRS410266 SRS410284 SRS410286 SRS410290 SRS420577)
epiroticus=(SAMN01087920)
christyi=(SRS228219)

for spe in "${species[@]}" 
	do	
		if [ ${spe} == "16G_arabiensis" ]	
		then	
			for sample in "${arabiensis[@]}" 	
			do	
				sbatch subordinate.sh ${spe} ${sample}
				echo "Data/${spe}/samples/${sample}"	
			done	
		elif [ ${spe} == "16G_merus" ]	
        	then
	                for sample in "${merus[@]}"	
			do	
				sbatch subordinate.sh ${spe} ${sample}
	                        echo "Data/${spe}/samples/${sample}"
	                done
		elif [ ${spe} == "16G_melas" ]	
		then
        	        for sample in "${melas[@]}"	
			do	
				sbatch subordinate.sh ${spe} ${sample}
		                echo "Data/${spe}/samples/${sample}"
			done
		elif [ ${spe} == "16G_quadriannulatus" ]	
	        then
         		for sample in "${quadriannulatus[@]}"	
			do
				sbatch subordinate.sh ${spe} ${sample}
        	                echo "Data/${spe}/samples/${sample}"
                	done
		elif [ ${spe} == "16G_epiroticus" ]	
        	then
                	for sample in "${epiroticus[@]}"	
			do	
				sbatch subordinate.sh ${spe} ${sample}
                	        echo "Data/${spe}/samples/${sample}"
	                done
		elif [ ${spe} == "16G_christyi" ]	
        	then
                	for sample in "${christyi[@]}"	
			do	
				sbatch subordinate.sh ${spe} ${sample}
                	        echo "Data/${spe}/samples/${sample}"
	                done
		elif [ ${spe} == "16G_bamako" ]	
        	then
                	for sample in "${bamako[@]}"	
			do	
				sbatch subordinate.sh ${spe} ${sample}
                	        echo "Data/${spe}/samples/${sample}"
	                done
		elif [ ${spe} == "16G_minimus" ]
		then
			for sample in "${minimus[@]}"
			do
				sbatch subordinate.sh ${spe} ${sample}
				echo "Data/${spe}/samples/${sample}"
			done 
		elif [ ${spe} == "16G_funestus" ]
		then
			for sample in "${funestus[@]}"
			do
				sbatch subordinate.sh ${spe} ${sample}
				echo "Data/${spe}/samples/${sample}"
			done 
		else [ ${spe} == "16G_gambiae" ]	
        	        for sample in "${gambiae[@]}"	
			do	
                	        echo "Data/${spe}/samples/${sample}"
				if [ ${sample} == "ND1_MIRA" ]	
				then
					for subsample in "${ND1_MIRA[@]}"	
					do
						sample="ND1"
						sbatch subordinateND_MIRA.sh ${spe} ${sample} ${subsample}
						echo "Data/${spe}/samples/${sample}/${subsample}"
					done
				elif [ ${sample} == "ND2_MIRA" ]	
				then
                	                for subsample in "${ND2_MIRA[@]}"	
					do
						sample="ND2"
						sbatch subordinateND_MIRA.sh ${spe} ${sample} ${subsample}
	                         	        echo "Data/${spe}/samples/${sample}/${subsample}"
	                                done
				elif [ ${sample} == "ND3_MIRA" ]	
				then
                        	        for subsample in "${ND3_MIRA[@]}"	
					do
						sample="ND3"
						sbatch subordinateND_MIRA.sh ${spe} ${sample} ${subsample}
        	                                echo "Data/${spe}/samples/${sample}/${subsample}"
	                                done
				elif [ ${sample} == "ND4_MIRA" ]
				then
					for subsample in "${ND4_MIRA[@]}"	
					do
						sample="ND4"
						sbatch subordinateND_MIRA.sh ${spe} ${sample} ${subsample}
                                	        echo "Data/${spe}/samples/${sample}/${subsample}"
	                                done
				elif [ ${sample} == "ND1_MITO" ]
                                then
                                        for subsample in "${ND1_MITO[@]}"
                                        do
						sample="ND1"
                                                sbatch subordinateND_MITO.sh ${spe} ${sample} ${subsample}
                                                echo "Data/${spe}/samples/${sample}/${subsample}"
                                        done
                                elif [ ${sample} == "ND2_MITO" ]
                                then
                                        for subsample in "${ND2_MITO[@]}"
                                        do
						sample="ND2"
                                                sbatch subordinateND_MITO.sh ${spe} ${sample} ${subsample}
                                                echo "Data/${spe}/samples/${sample}/${subsample}"
                                        done
                                elif [ ${sample} == "ND3_MITO" ]
                                then
                                        for subsample in "${ND3_MITO[@]}"
                                        do
						sample="ND3"
                                                sbatch subordinateND_MITO.sh ${spe} ${sample} ${subsample}
                                                echo "Data/${spe}/samples/${sample}/${subsample}"
                                        done
                                else
                                        for subsample in "${ND4_MITO[@]}"
                                        do
						sample="ND4"
                                                sbatch subordinateND_MITO.sh ${spe} ${sample} ${subsample}
                                                echo "Data/${spe}/samples/${sample}/${subsample}"
                                        done
				fi
	                done
		fi
	done
