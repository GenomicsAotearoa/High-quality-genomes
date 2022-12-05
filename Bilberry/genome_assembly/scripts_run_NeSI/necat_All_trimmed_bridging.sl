#!/bin/bash -e
#SBATCH --job-name=necat_bridge
#SBATCH --account=ga02824
#SBATCH --time=50:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=80000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

export PATH=/nesi/project/ga02824/programs/NECAT/NECAT/Linux-amd64/bin/:$PATH
module load Perl/5.28.1-gimkl-2018b

necat.pl bridge bilberry_config.txt 

