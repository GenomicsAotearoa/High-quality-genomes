#!/bin/bash -e
#SBATCH --job-name=flye
#SBATCH --account=ga02824
#SBATCH --time=160:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=280000 # Memory in MB
#SBATCH --partition=bigmem
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL


export PATH=/nesi/project/ga02824/programs/Flye/bin:$PATH

flye --nano-raw /nesi/nobackup/ga02824/001.RawData/All.fastq.gz --genome-size 600m -o /nesi/nobackup/ga02824/003.Flye/Flye_All_i2 -t 36 -i 2
