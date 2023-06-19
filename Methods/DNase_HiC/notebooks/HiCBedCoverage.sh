cd /workspace/hraijc/HiC_trials/Coverage/target_capture/

module load samtools
samtools sort Russell_V2a_chromosomes_only_dedup.bam -o Russell_V2a_chromosomes_only_dedup_sorted.bam


module load bedtools
bedtools genomecov -ibam Russell_V2a_chromosomes_only_dedup_sorted.bam -bg | awk '$4>20' > Russell_HiCTC-T2.bed

cat Russell_HiCTC.bed | awk '$4>200' > Russell_HiCTC_200min.bed  
cat Russell_HiCTC_200min.bed | awk '$4>1000' > Russell_HiCTC_1000min.bed  

