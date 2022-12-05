#!/bin/bash -e
#SBATCH --job-name=reformat
#SBATCH --account=ga02824
#SBATCH --time=01:00:00
#SBATCH --mem=3000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

export PATH=/nesi/project/ga02824/programs/Shasta/shasta/scripts:$PATH

python /nesi/project/ga02824/programs/Shasta/shasta/scripts/FastqGzToFasta.py /nesi/nobackup/ga02824/009.filtlong/All_Promethion_60C.fastq.gz /nesi/project/ga02824/002.QC/All_Promethion_60C.fasta

