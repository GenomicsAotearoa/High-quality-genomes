#!/bin/bash -e
#SBATCH --job-name=consent
#SBATCH --account=ga02824
#SBATCH --time=150:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=800000 # Memory in MB
#SBATCH --partition=hugemem
#SBATCH --mail-user=chen.wu@plantandfood.co.nz
#SBATCH --mail-type=ALL

export PATH=/nesi/project/nesi99999/Dinindu/CondaEnv/fpa/bin/:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/nesi/project/nesi99999/Dinindu/CondaEnv/fpa/lib/

module load XZ/5.2.3-gimkl-2018b

export PATH=/nesi/project/ga02824/programs/CONSENT/:$PATH
export PATH=/nesi/project/ga02824/programs/CONSENT/minimap2/:$PATH

CONSENT-correct -j 36 --in /nesi/nobackup/ga02824/002.QC/All_AdapterRemoved.fasta \
--out /nesi/nobackup/ga02824/008.consent/All_consent_corrected.fasta --type ONT \
--tmpdir /nesi/nobackup/ga02824/008.consent/
