#!/bin/bash -e
#SBATCH --job-name=readLengthIdentity_Pro60C
#SBATCH --account=ga02824
#SBATCH --time=10:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

/nesi/project/ga02824/programs/Filtlong/scripts/read_info_histograms.sh /nesi/nobackup/ga02824/009.filtlong/All_Promethion_60C.fastq.gz > readInfoHistograms_Pro60C_summary.txt
