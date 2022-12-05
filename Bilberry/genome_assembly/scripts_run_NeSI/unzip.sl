#!/bin/bash -e
#SBATCH --job-name=unzip
#SBATCH --account=ga02824
#SBATCH --time=02:00:00
#SBATCH --mem=3000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

gunzip -c /nesi/nobackup/ga02824/002.QC/All_AdapterRemoved.fastq.gz
