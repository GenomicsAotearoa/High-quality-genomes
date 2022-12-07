genomeFasta=/workspace/hrachd/Bilberry/2020/10_Masked.annotation/01_softMask/Bilberry.NCBI.fa.masked
workDir=/workspace/hrachd/Bilberry/2020/16_SoftMask/01_Index
logDir=$workDir/.log
mkdir -p $logDir
thread=10
genome=BilberryNCBI'.softmask.fa'


## STAR index
module load STAR/2.6.1d

cd $workDir
ln -s $genomeFasta $genome


bsub -m aklppb39 -n $thread -o $logDir/starIndex.stdout -e $logDir/starIndex.stderr -J index "STAR --runMode genomeGenerate --limitGenomeGenerateRAM 4234891648 --runThreadN $thread --genomeFastaFiles $genome --genomeDir $workDir"


## minimap2 index
module load minimap2/2.17
cd $workDir
minimap2 -d $genome'.mmi' $genome > LOG.staridx.log 2>LOG.staridx.err &

