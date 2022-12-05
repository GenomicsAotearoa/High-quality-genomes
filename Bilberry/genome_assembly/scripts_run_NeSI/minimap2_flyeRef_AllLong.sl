#!/bin/bash -e
#SBATCH --job-name=minimap2_FlyeRef_AllLong
#SBATCH --account=ga02824
#SBATCH --time=10:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=80000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

module load minimap2/2.16-gimkl-2018b

minimap2 -x map10k -t 24 -c /nesi/project/ga02824/003.Flye/assembly.fasta /nesi/project/ga02824/002.QC/All.fastq.gz > alignments_FlyeRef_AllLong.paf
