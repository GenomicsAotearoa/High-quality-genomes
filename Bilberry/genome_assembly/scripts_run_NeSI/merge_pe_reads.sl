#!/bin/bash -e
#SBATCH --job-name=pe_merge
#SBATCH --account=ga02824
#SBATCH --time=20:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL


export PATH=/nesi/project/ga02824/programs/colormap/bin

fastUtils shuffle -1 /nesi/project/ga02824/001.RawData/IlluminaSeqs/AGRF_CAGRF20139_HMHTHDSXX/Clean_Billbery_HMHTHDSXX_CTAGCGCT-GTGTAGAC_L001_R1.fastq.gz -2 /nesi/project/ga02824/001.RawData/IlluminaSeqs/AGRF_CAGRF20139_HMHTHDSXX/Clean_Billbery_HMHTHDSXX_CTAGCGCT-GTGTAGAC_L001_R2.fastq.gz -o /nesi/nobackup/ga02824/012.colormap/interleaved_pe_reads.fastq


