# Adjust star mapping parameters 
Add this for star alignment:
extra_star_align_args      = '--outFilterMismatchNmax 50 --outFilterMismatchNoverLmax 0.5 --alignIntronMax 10000'


# Run
module purge
ml nextflow/22.10.4
ml apptainer/1.1

cd /workspace/hrachd/hrachd/GitHub/Other/rnaseq
sbatch -J Hap1 --nodes=1 --ntasks=1 --cpus-per-task=32 --mem=50G --output=LOG/GilleniaHap1.log --error=LOG/GilleniaHap1.err --time=24:00:10 --wrap="nextflow run main.nf -profile GilleniaHap1,singularity --outdir results/GilleniaHap1_max50"

Submitted batch job 993109 


## Move to /output
cd /workspace/hrachd/hrachd/GitHub/Other/rnaseq/results
outDir=/output/genomic/plant/Gillenia/trifoliata/2023_RNASeq_ER10986/202302_LooseAlign

