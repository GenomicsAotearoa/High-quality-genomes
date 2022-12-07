## Braker2 --softmasking
## Run on wkoppb50
thread=30
genome=/workspace/hrachd/Bilberry/2020/10_Masked.annotation/01_softMask/Bilberry.NCBI.fa.masked

## Illumina RNASeq mapping to the hardmasked genome
starDir=/workspace/hrachd/Bilberry/2020/16_SoftMask/05_Star

## Transcripts and ONT/RNA mapped to the hardmasked genome
minimap2Dir=/workspace/hrachd/Bilberry/2020/16_SoftMask/02_minimap2

bamDir=/workspace/hrachd/Bilberry/2020/16_SoftMask/07_BamDir

## Result
outDir=/workspace/hrachd/Bilberry/2020/16_SoftMask/10_Braker
#mkdir -p $outDir

module purge; 
module load perl/bio-extras; 
module load bamtools/2.4.0; 
module load GeneMark/4.33; 
module load samtools/1.9; 
module load ncbi-blast/2.6.0; 
module load augustus/3.2.2; 
module load BRAKER/2.1.0; 
module load pfr-python3/3.6.1

cd $bamDir

/software/bioinformatics/BRAKER-2.1.0/braker.pl --softmasking --genome=$genome --bam=Flesh.ontRNAs.srt.bam,Flesh.transcripts.srt.bam,Skin.ontRNAs.srt.bam,Skin.transcripts.srt.bam,WholeBerry.transcripts.srt.bam,VmLeavesAligned.sortedByCoord.out.bam,VmRootsAligned.sortedByCoord.out.bam,VmS30Pu1916Aligned.sortedByCoord.out.bam,VmS30Sk1901Aligned.sortedByCoord.out.bam,VmS30WF1932Aligned.sortedByCoord.out.bam,VmS35Pu1919Aligned.sortedByCoord.out.bam,VmS35Sk1904Aligned.sortedByCoord.out.bam,VmS35WF1934Aligned.sortedByCoord.out.bam,VmS40Pu1922Aligned.sortedByCoord.out.bam,VmS40Sk1907Aligned.sortedByCoord.out.bam,VmS40WF1937Aligned.sortedByCoord.out.bam,VmS45Pu1925Aligned.sortedByCoord.out.bam,VmS45Sk1910Aligned.sortedByCoord.out.bam,VmS45WF1940Aligned.sortedByCoord.out.bam,VmS50Pu1928Aligned.sortedByCoord.out.bam,VmS50Sk1913Aligned.sortedByCoord.out.bam,VmS50WF1943Aligned.sortedByCoord.out.bam --species=Bilberry.NCBI.softmasking --gff3 --cores=$thread --workingdir=$outDir --augustus_args='--strand=both --genemodel=complete --alternatives-from-evidence=true --noInFrameStop=true' --overwrite --AUGUSTUS_BIN_PATH=/software/bioinformatics/augustus-3.2.2/bin --AUGUSTUS_SCRIPTS_PATH=/software/bioinformatics/augustus-3.2.2/scripts --AUGUSTUS_CONFIG_PATH=/workspace/hrachd/hrachd/GitHub/Other/Cecilia_Augustus/config > $outDir/LOG.Braker2.out 2>$outDir/LOG.Braker2.err &


## Get protein and codingseq
/software/bioinformatics/augustus-3.2.2/scripts/getAnnoFasta.pl augustus.hints.gff



## Create tarball for backup
cd /workspace/hrachd/Bilberry/2020/16_SoftMask
tar -czvf Bilberry.NCBI.Softmasked.Braker.tgz 10_Braker/README.md 10_Braker/augustus.hints.* 10_Braker/GeneMark-ET/genemark.gtf 10_Braker/genemark_hintsfile.gff 


