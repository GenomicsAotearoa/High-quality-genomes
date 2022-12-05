#!/bin/bash -e
#SBATCH --job-name=readLengthIdentity_FlyeRef_AllLong
#SBATCH --account=ga02824
#SBATCH --time=15:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

module load Python/3.7.3-gimkl-2018b

python /nesi/project/ga02824/programs/Filtlong/misc/read_length_identity.py /nesi/nobackup/009.filtlong/alignments_FlyeRef_AllLong.paf > /nesi/nobackup/009.filtlong/read_stats_FlyeRef_AllLong.tsv
