#!/bin/bash -e
#SBATCH --job-name=flye
#SBATCH --account=ga02824
#SBATCH --time=1:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL


export PATH=/nesi/project/ga02824/programs/assembly-stats-17.02/pl:$PATH

asm2stats.pl /nesi/nobackup/ga02824/003.Flye/assembly.fasta > /nesi/nobackup/ga02824/003.Flye/assembly-stats_flye.json
