#!/bin/bash -e
#SBATCH --job-name=kat
#SBATCH --account=ga02824
#SBATCH --time=20:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=280000 # Memory in MB
#SBATCH --partition=bigmem
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL


module load KAT/2.4.2-gimkl-2018b-Python-3.7.3

kat hist -o kat_all.hist -t 10 -p png /nesi/project/ga02824/002.QC/All.fastq.gz
