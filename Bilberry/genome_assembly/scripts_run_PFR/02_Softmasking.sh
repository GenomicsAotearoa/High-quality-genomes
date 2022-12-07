## EDTA.pl created Bilberry.NCBI.fa.mod.MAKER.masked
## However, it was NOT softmasked
## Decide to do softmasking by myself
thread=10
libFile=/output/genomic/plant/Vaccinium/myrtillus/Genome/NCBI.AssemblyAnnotation/01_Repeats/Bilberry.NCBI/Bilberry.NCBI.fa.mod.EDTA.TElib.fa

genome=Bilberry.NCBI.fa

module load singularity

singularity exec /workspace/hraegb/singularity/repeatmasker-4.1.1.sif RepeatMasker -pa 10 -e ncbi -gff -xsmall -lib $libFile $genome > .Singularity.log 2>.Singularity.err &



