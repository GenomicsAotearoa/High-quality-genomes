#!/bin/bash -e
#SBATCH --job-name=filtlong
#SBATCH --account=ga02824
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=80000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

export PATH=/nesi/project/ga02824/programs/Filtlong/bin/:$PATH

IlluminaPath=/nesi/project/ga02824/001.RawData/IlluminaSeqs/AGRF_CAGRF20139_HMHTHDSXX

filtlong -1 $IlluminaPath/Clean_Billbery_HMHTHDSXX_CTAGCGCT-GTGTAGAC_L001_R1.fastq.gz \
-2 $IlluminaPath/Clean_Billbery_HMHTHDSXX_CTAGCGCT-GTGTAGAC_L001_R2.fastq.gz \
--min_length 1000 --min_window_q 60 --keep_percent 90 --target_bases 50000000000 --length_weight 10 \
/nesi/nobackup/ga02824/001.RawData/All_Promethion.fastq.gz | gzip > /nesi/nobackup/ga02824/009.filtlong/All_AdapterRemoved_50G_WithIllumina_noTrim_noSplit.fastq.gz

