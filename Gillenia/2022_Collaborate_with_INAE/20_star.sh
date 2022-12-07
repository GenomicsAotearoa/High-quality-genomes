module load STAR/2.7.10a;

hap2=/output/genomic/plant/Gillenia/trifoliata/2022_Scaffolding/ReleaseV1/05_EDTA/EDTA_1stRun/RM_softmasking/Gillenia.hap1.hap2.fa.mod.EDTAlib.softmasked.hap2.fa
hap1=/output/genomic/plant/Gillenia/trifoliata/2022_Scaffolding/ReleaseV1/05_EDTA/EDTA_1stRun/RM_softmasking/Gillenia.hap1.hap2.fa.mod.EDTAlib.softmasked.hap1.fa

workDir=/workspace/hrachd/Gillenia/2022/03_Braker2
logDir=$workDir/.log
bamBaseDir=/workspace/hrachd/Gillenia/2022/03_Braker2

rnaDataDir=/input/genomic/plant/Gillenia/trifoliata/RNASeq/AGRF_CAGRF16826_CC8M4ANXX
S6R1=GT11S56_CC8M4ANXX_CGATGT_L008_R1.fastq.gz
S6R2=GT11S56_CC8M4ANXX_CGATGT_L008_R2.fastq.gz
S9R1=GT11S59_CC8M4ANXX_CAGATC_L008_R1.fastq.gz
S9R2=GT11S59_CC8M4ANXX_CAGATC_L008_R2.fastq.gz

thread=10

cd $rnaDataDir

for hap in hap1 hap2
do
   bamDir=$bamBaseDir/$hap
   S6bamFile=$hap'S6'
   hapIndex=$workDir/$hap/STARIDX
   bsub -R "span[hosts=1] & rusage[mem=30000]" -o $logDir/$hap'S6.log' -e $logDir/$hap'S6.err' -J S6$hap -n $thread "STAR --runThreadN $thread --genomeDir $hapIndex --readFilesIn $S6R1 $S6R2 --readFilesCommand zcat --outFileNamePrefix $bamDir/$S6bamFile --outSAMtype BAM SortedByCoordinate"
   S9bamFile=$hap'S9'
   bsub -R "span[hosts=1] & rusage[mem=30000]" -o $logDir/$hap'S9.log' -e $logDir/$hap'S9.err' -J S9$hap -n $thread "STAR --runThreadN $thread --genomeDir $hapIndex --readFilesIn $S9R1 $S9R2 --readFilesCommand zcat --outFileNamePrefix $bamDir/$S9bamFile --outSAMtype BAM SortedByCoordinate"
done


