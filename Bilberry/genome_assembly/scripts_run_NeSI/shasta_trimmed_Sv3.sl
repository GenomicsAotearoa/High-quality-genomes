#!/bin/bash -e
#SBATCH --job-name=shasta
#SBATCH --account=ga02824
#SBATCH --time=5:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=280000 # Memory in MB
#SBATCH --partition=bigmem
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL


export PATH=/nesi/project/ga02824/programs/Shasta:$PATH

shasta-Linux-0.3.0 --input /nesi/nobackup/ga02824/002.QC/All_AdapterRemoved.fasta \
--assemblyDirectory /nesi/nobackup/ga02824/006.shasta/test_All_trimmed_0.3.0 \
--threads 36
