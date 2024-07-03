#!/bin/bash 
#PBS -q regular 
#PBS -N name
#PBS -l nodes=1:ppn=4 
#PBS -l walltime=9920:00:00 
#PBS -l mem=100gb 
 
cd $PATH
fastp -i $SAMPLE.R1.fastq.gz -I $SAMPLE.R2.fastq.gz -o $SAMPLE_1.trim.fastq.gz -O $SAMPLE_2.trim.fastq.gz -h $SAMPLE.html 

# reads alignment 
hisat2 -p 2 --dta -x $GENOME -1 $SAMPLE_1.trim.fastq.gz -2 $SAMPLE_2.trim.fastq.gz -S $SAMPLE.sam 
## sort aligned reads and convert to bam 
samtools sort -o $SAMPLE.bam $SAMPLE.sam 
rm $SAMPLE.sam
samtools view -b -q 5 -o $SAMPLE.clean.bam $SAMPLE.bam


