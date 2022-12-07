module load conda
export PATH=/software/programming/miniconda3_4.10.3/bin:$PATH
source activate EDTA

thread=20
genome=/workspace/hrachd/Bilberry/2020/10_Masked.annotation/01_softMask/Bilberry.NCBI.fa.masked

## Run EDTA
bsub -R "span[hosts=1]" -J $species -m aklppb30 -o .log/01_EDTA.log -e .log/01_EDTA.err -n $thread "EDTA.pl --genome $genome --species others --step all --sensitive 1 --anno 1 --threads $thread"

