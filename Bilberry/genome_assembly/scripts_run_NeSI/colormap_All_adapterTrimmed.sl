#!/bin/bash -e
#SBATCH --job-name=colormap
#SBATCH --account=ga02824
#SBATCH --time=120:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=480000 # Memory in MB
#SBATCH --partition=bigmem
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

module load BWA/0.7.17-gimkl-2017a
module load SAMtools/1.9-GCC-7.4.0

export PATH=/nesi/project/ga02824/programs/colormap/utils/minia/build/bin/:$PATH
export PATH=/nesi/project/ga02824/programs/colormap/:$PATH

runCorr.sh /nesi/nobackup/ga02824/002.QC/All_AdapterRemoved.fasta /nesi/nobackup/ga02824/012.colormap/interleaved_pe_reads.fastq /nesi/nobackup/ga02824/012.colormap pre 24

