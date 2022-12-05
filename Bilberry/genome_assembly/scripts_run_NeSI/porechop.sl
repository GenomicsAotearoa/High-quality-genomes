#!/bin/bash -e
#SBATCH --job-name=pycoQC
#SBATCH --account=ga02824
#SBATCH --time=10:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=200000 # Memory in MB
#SBATCH --partition=bigmem
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

module load Porechop/0.2.4-gimkl-2018b-Python-3.7.3

porechop -i All.fastq.gz -o All_AdapterRemoved.fastq.gz -t 12 --discard_middle
