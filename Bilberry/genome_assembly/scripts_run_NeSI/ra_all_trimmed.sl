#!/bin/bash -e
#SBATCH --job-name=ra
#SBATCH --account=ga02824
#SBATCH --time=120:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=280000 # Memory in MB
#SBATCH --partition=bigmem
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

export PATH=/nesi/project/ga02824/programs/ra/build/bin/:$PATH

ra -t 36 -x ont /nesi/nobackup/ga02824/002.QC/All_AdapterRemoved.fastq.gz \
/nesi/project/ga02824/001.RawData/IlluminaSeqs/AGRF_CAGRF20139_HMHTHDSXX/Clean_Billbery_HMHTHDSXX_CTAGCGCT-GTGTAGAC_L001_R1.fastq.gz
