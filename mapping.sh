#!/bin/bash 
#PBS -q regular 
#PBS -N name
#PBS -l nodes=1:ppn=4 
#PBS -l walltime=120:00:00 
#PBS -l mem=40gb 
 
cd $PATH

fastp -i $SAMPLE.R1.gz -I $SAMPLE.R2.gz -o $SAMPLE_1.trim.fastq.gz -O $SAMPLE_2.trim.fastq.gz -h $SAMPLE.html -j $SAMPLE.json 

# bowtie2 mapping 
bowtie2 -x $GENOME -p 4 -X 1000 -S $SAMPLE.sam -1 $SAMPLE_1.trim.fastq.gz -2 $SAMPLE_2.trim.fastq.gz --very-sensitive
 
## remove reads with MAPQ < 10 
samtools view -b -q 10 -o $SAMPLE.bam $SAMPLE.sam 
 
# sort sam to bam 
samtools sort -O 'bam' -o $SAMPLE.sorted.bam -T tmp $SAMPLE.bam 

# remove clonal picard 2.21.9 
samtools index -c $SAMPLE.sorted.bam
java -Xmx20g -jar picard.jar MarkDuplicates INPUT=$SAMPLE.sorted.bam OUTPUT=$SAMPLE.clean.bam METRICS_FILE=XXX.txt REMOVE_DUPLICATES=true VALIDATION_STRINGENCY=LENIENT 
 
# bam to bed bedtools 2.26.0 
bedtools bamtobed -i Leaf-1.clean.bam > Leaf-1.bed 
 
rm *.trim.fastq.gz 
rm Leaf-1.sam Leaf-1.bam Leaf-1.sorted.bam 

