# Adjust star mapping parameters 
#extra_star_align_args      = '--outFilterMismatchNmax 50 --outFilterMismatchNoverLmax 0.5'


# Run
module purge
ml nextflow/22.10.4
ml apptainer/1.1

cd /workspace/hrachd/hrachd/GitHub/Other/rnaseq
mkdir results/GilleniaHap2_max50

sbatch -J Hap2 --nodes=1 --ntasks=1 --cpus-per-task=32 --mem=50G --output=LOG/GilleniaHap2Loose.log --error=LOG/GilleniaHap2Loose.err --time=24:00:10 --wrap="nextflow run main.nf -profile GilleniaHap2,singularity --outdir results/GilleniaHap2_max50"
Submitted batch job 993469 



## Move to /output
cd /workspace/hrachd/hrachd/GitHub/Other/rnaseq/results
outDir=/output/genomic/plant/Gillenia/trifoliata/2023_RNASeq_ER10986/202302_LooseAlign
