#!/bin/bash -e
#SBATCH --job-name=filtlong
#SBATCH --account=ga02824
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=80000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

export PATH=/nesi/project/ga02824/programs/Filtlong/bin/:$PATH

filtlong --target_bases 36000000000 --min_length 1000 /nesi/project/ga02824/002.QC/All_Promethion.fastq.gz | gzip > /nesi/nobackup/ga02824/009.filtlong/All_Promethion_60C.fastq.gz

