#!/bin/bash -e
#SBATCH --job-name=necat
#SBATCH --account=ga02824
#SBATCH --time=80:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=280000 # Memory in MB
#SBATCH --partition=bigmem
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

export PATH=/nesi/project/ga02824/programs/NECAT/NECAT/Linux-amd64/bin/:$PATH
module load Perl/5.28.1-gimkl-2018b

necat.pl correct bilberry_config.txt 

