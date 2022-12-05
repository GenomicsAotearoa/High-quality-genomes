#!/bin/bash -e
#SBATCH --job-name=jellyfish_count
#SBATCH --account=ga02824
#SBATCH --time=5:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=160000 # Memory in MB
#SBATCH --partition=bigmem
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

module load Jellyfish/2.2.10-gimkl-2018b

jellyfish count -C -s 150000000000 -m 21 -t 36 \
/nesi/project/ga02824/001.RawData/IlluminaSeqs/AGRF_CAGRF20139_HMHTHDSXX/*.fastq.gz \
-o /nesi/nobackup/ga02824/016.genomeScope/reads.jf
