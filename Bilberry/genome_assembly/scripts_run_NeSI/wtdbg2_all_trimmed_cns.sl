#!/bin/bash -e
#SBATCH --job-name=wtdbg2
#SBATCH --account=ga02824
#SBATCH --time=60:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=80000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

export PATH=/nesi/project/ga02824/programs/wtdbg2/:$PATH

wtdbg-cns -t 24 -i /nesi/nobackup/ga02824/013.wtdbg2/013.wtdbg2.ctg.lay.gz -fo /nesi/nobackup/ga02824/013.wtdbg2/assembly.raw.fa
