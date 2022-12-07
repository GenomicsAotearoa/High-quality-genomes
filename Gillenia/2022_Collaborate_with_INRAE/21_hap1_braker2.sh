## Hap1: Prediction genes. Do the same for Hap2
hap1BrakerDir=/workspace/hrachd/Gillenia/2022/03_Braker2/Hap1/Braker2
logDir=/workspace/hrachd/Gillenia/2022/03_Braker2/.log


workDir=/workspace/hrachd/Gillenia/2022/03_Braker2/Hap1
idxDir=STARIDX
thread=30

genome=$workDir/Gillenia.hap1.softmasked.fa
bamDir=$workDir
outDir=$workDir/Braker2

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

## --augustus_args should also  with '--protein=on --codingseq=on'
bsub -o $logDir/10_hap1OldBraker.log -e $logDir/10_hap1OldBraker.err -J hap1 -R "span[hosts=1] & rusage[mem=30000]" "braker.pl --softmasking --genome=$genome --bam=hap1S6Aligned.sortedByCoord.out.bam,hap1S9Aligned.sortedByCoord.out.bam --species=GilleniaHap1 --gff3 --cores=$thread --workingdir=$outDir --augustus_args='--strand=both --genemodel=complete --alternatives-from-evidence=true --noInFrameStop=true' --overwrite --AUGUSTUS_BIN_PATH=/software/bioinformatics/augustus-3.2.2/bin --AUGUSTUS_SCRIPTS_PATH=/software/bioinformatics/augustus-3.2.2/scripts --AUGUSTUS_CONFIG_PATH=/workspace/hrachd/hrachd/GitHub/Other/Cecilia_Augustus/config"




## extract sequence, Hap1
cd /workspace/hrachd/Gillenia/2022/03_Braker2/Hap1/Braker2
/software/bioinformatics/augustus-3.2.2/scripts/getAnnoFasta.pl --seqfile=/workspace/hrachd/Gillenia/2022/03_Braker2/Hap1/Gillenia.hap1.softmasked.fa augustus.hints.gff3 
module load emboss;
transeq -sequence augustus.hints3.codingseq -outseq augustus.hints3.protein.faa

## Add hap number to gene IDs
mkdir Hap1Genes

cp augustus.hints3.codingseq  augustus.hints3.mrna augustus.hints3.protein.faa augustus.hints.gff3 Hap1Genes/
cd Hap1Genes/
perl -p -i -e 's/ID=/ID=Hap1/g; s/Parent=/Parent=Hap1/g;' augustus.hints.gff3

for sufix in codingseq mrna protein.faa
do
   inFile='augustus.hints3.'$sufix
   perl -p -i -e 's/^>/>Hap1/g' $inFile
done


