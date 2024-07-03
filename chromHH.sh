#!/bin/bash 
#PBS -q regular 
#PBS -N name
#PBS -l nodes=1:ppn=4 
#PBS -l walltime=999:00:00 
#PBS -l mem=80gb 
 
cd $PATH

#Binarize
java -jar -Xmx81920m ChromHMM.jar Binarizebed -b 200 $GENOMESIZE $DIR $FILE $NAME
#model
java -jar -Xmx81920m ChromHMM.jar LearnModel $BinarizeBedNAME $NAME 30 $GENOME
