#!/bin/bash -e
#SBATCH --job-name=BUSCO
#SBATCH --account=ga02824
#SBATCH --time=1:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=10000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

cp -r $AUGUSTUS_CONFIG_PATH ~/MyAugustusConfig
export AUGUSTUS_CONFIG_PATH=~/MyAugustusConfig

module load BUSCO/3.0.2-gimkl-2018b

run_BUSCO.py -i /nesi/nobackup/ga02824/006.shasta/test/Assembly.fasta -o Shasta_test.busco -l /nesi/project/ga02824/005.BUSCO/embryophyta_odb10 -m genome -c 12
