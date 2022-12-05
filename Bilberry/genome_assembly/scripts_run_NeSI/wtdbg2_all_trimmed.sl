#!/bin/bash -e
#SBATCH --job-name=wtdbg2
#SBATCH --account=ga02824
#SBATCH --time=60:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=280000 # Memory in MB
#SBATCH --partition=bigmem
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

export PATH=/nesi/project/ga02824/programs/wtdbg2/:$PATH

wtdbg2 -x ont,preset2 -g 600m -t 24 -L 1000 -i /nesi/nobackup/ga02824/002.QC/All_AdapterRemoved.fastq.gz -fo /nesi/nobackup/ga02824/013.wtdbg2
