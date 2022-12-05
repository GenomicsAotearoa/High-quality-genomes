#!/bin/bash -e
#SBATCH --job-name=multi-to-single
#SBATCH --account=ga02824
#SBATCH --time=01:00:00
#SBATCH --mem=3000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

export PATH=/nesi/project/ga02824/programs/Convert-Multiline-Fasta-to-Single-line-Fasta:$PATH
module load Python/3.7.3-gimkl-2018b

python3 /nesi/project/ga02824/programs/Convert-Multiline-Fasta-to-Single-line-Fasta/Multiline_fasta_convert_general.py /nesi/project/ga02824/002.QC/All.fasta > /nesi/project/ga02824/002.QC/All_singleLine.fasta

