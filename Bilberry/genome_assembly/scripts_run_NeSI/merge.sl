#!/bin/bash -e
#SBATCH --job-name=merge
#SBATCH --account=ga02824
#SBATCH --time=00:50:00
#SBATCH --mem=3000 # Memory in MB
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL


INDIR=/nesi/project/ga02824/001.RawData/NanoporeSeqs

cat $INDIR/AGRF_CAGRF20139_FAK89700_BILBERRY/fastq_pass/*.fastq.gz $INDIR/AGRF_CAGRF20139_PAD63179_BILBERRY/fastq_pass/*.fastq.gz > All.fastq.gz

