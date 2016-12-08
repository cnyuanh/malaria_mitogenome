#!/bin/env python

#Description: Extract stats from LibDiversity
#Written by: Jorge Edaurdo Amaya Romero
#Last time: 18-11-2016

import csv
import os
import sys
import re

names = sys.argv[3]
sequences = sys.argv[4]
sample_size=int(sys.argv[5])

N_sequences = "nan"
N_sites = "nan"
transitions_1 ="nan" 
transitions_2 = "nan"
transversions_1 ="nan"
transversions_2 ="nan"
S_1 ="nan"
S_2 ="nan"
theta_S_1 ="nan"
theta_S_2 = "nan"
pi = "nan"
theta_pi_1 ="nan"
theta_pi_2 = "nan"
eta1 ="nan"
theta_eta1_1 ="nan"
theta_eta1_2 ="nan"
S_eta1 ="nan"
theta_S_eta1_1 ="nan"
theta_S_eta1_2 ="nan"
pi_eta1 ="nan"
theta_pi_eta1_1 ="nan"
theta_pi_eta1_2 ="nan"
Haplotypes ="nan"
Tajima ="nan"
Tajima_p ="nan"
Fu_and_LiD ="nan"
Fu_and_LiD_p ="nan"
Fu_and_LiF ="nan"
Fu_and_LiF_p = "nan"

input_file=sequences

with open(input_file, "r") as f, open("".join([sys.argv[2],"/Stats.csv"]), "a") as w:
	writer = csv.writer(w,delimiter =";")
	writer.writerow(["names","sequences","N_sequences","N_sites","transitions_1","transitions_2","transversions_1","transversions_2","S_1","S_2","theta_S_1","theta_S_2","pi","theta_pi_1","theta_pi_2","eta1","theta_eta1_1","theta_eta1_bp","S_-eta1","theta_S_-eta1","theta_S_-eta1_bp","pi_-eta1","theta_pi_-eta1","theta_pi_-eta1_bp","Haplotypes","Tajima","Tajima_p","Fu_and_LiD","Fu_and_LiD_p","Fu_and_LiF","Fu_and_LiF_p"])
	for line in f:
#		print(line)
		if(re.search("Nsequences",line)):
			N_sequences = re.split('\s+', line)[2]
			N_sites = re.split('\s+', line)[5]
		elif(re.search("ts=",line)):
			transitions_1 = re.split('\s+', line)[1]			
			transitions_2 = re.split('\s+', line)[2].strip("()")			
		elif(re.search("tv=",line)):
			transversions_1 = re.split('\s+', line)[1]			
			transversions_2 = re.split('\s+', line)[2].strip("()")			
		elif(re.search(r"^S=",line)):
			S_1 = re.split('\s+', line)[1]			
			S_2 = re.split('\s+', line)[2].strip("()")
		elif(re.search("theta_S=",line)):
			theta_S_1 = re.split('\s+', line)[1]
			theta_S_2 = re.split('\s+', line)[2].strip("()")
		elif(re.search(r"^pi=",line)): 
			pi = re.split('\s+', line)[1]
		elif(re.search("theta_pi=",line)): 
			theta_pi_1 = re.split('\s+',line)[1]
			theta_pi_2 = re.split('\s+',line)[2].strip("()")
		elif(re.search(r"^eta1=",line)): 
			eta1 = re.split('\s+', line)[1]
		elif(re.search("theta_eta1=",line)): 
			theta_eta1_1 = re.split('\s+',line)[1]
			theta_eta1_2 = re.split('\s+',line)[2].strip("()")
		elif(re.search(r"^S_-eta1=",line)): 
			S_eta1 = re.split('\s+', line)[1]
		elif(re.search("theta_S_-eta1=",line)): 
			theta_S_eta1_1 = re.split('\s+',line)[1]
			theta_S_eta1_2 = re.split('\s+',line)[2].strip("()")
		elif(re.search(r"^pi_-eta1=",line)): 
			pi_eta1 = re.split('\s+', line)[1]
		elif(re.search("theta_pi_-eta1=",line)): 
			theta_pi_eta1_1 = re.split('\s+',line)[1]
			theta_pi_eta1_2 = re.split('\s+',line)[2].strip("()")
		elif(re.search("H=",line)): 
			Haplotypes = re.split('\s+',line)[1]
		elif(re.search("Tajima",line)): 
			Tajima = re.split('\s+',line)[3]
			Tajima_p = re.split('\s+',line)[5]
		elif(re.search("Fu&Li D",line)): 
			Fu_and_LiD = re.split('\s+',line)[3]
			Fu_and_LiD_p = re.split('\s+',line)[5]
		elif(re.search("Fu&Li F",line)): 
			Fu_and_LiF = re.split('\s+',line)[3]
			Fu_and_LiF_p = re.split('\s+',line)[5]
	
	writer.writerow([names,sample_size,N_sequences,N_sites,transitions_1,transitions_2,transversions_1,transversions_2,S_1,S_2,theta_S_1,theta_S_2,pi,theta_pi_1,theta_pi_2,eta1,theta_eta1_1,theta_eta1_2,S_eta1,theta_S_eta1_1,theta_S_eta1_2,pi_eta1,theta_pi_eta1_1,theta_pi_eta1_2,Haplotypes,Tajima,Tajima_p,Fu_and_LiD,Fu_and_LiD_p,Fu_and_LiF,Fu_and_LiF_p])

