workDir=/workspace/hrachd/Fish/2021/HiC/11_200M_data
logDir=$workDir/20_bam2fltTxt
#mkdir -p $logDir

cd $workDir
bamFile=HH_HiC200M.mapped.PT.bam
qualFltFile=HH_HiC200M.mapped.PT.contact_map_1k_qualFilt.txt

module load samtools/1.12

#bsub -q priority -P P/952006/04 -J b2flt -o $logDire/01_convert.log -e $logDire/01_convert.err "samtools view $bamFile | /workspace/hrpazs/bilberry_genome/filter_reads.awk -v isize=0 q=0 | /workspace/hrpazs/software/dryhic/inst/src/reads_to_bins_whole.awk -v w=1000 > $qualFltFile"
#Job <180284> is submitted to queue <priority>.


## genome seq length
genome=/output/genomic/fish/Macruronus/novaezelandiae/Assembly/Mno_genome.FLYE.PILON.noBac.fasta
ln -s $genome Mno_genome.FLYE.fa
samtools faidx Mno_genome.FLYE.fa

perl -lane 'print join(",", $F[0], $F[1]);' Mno_genome.FLYE.fa.fai > Mno_genome.FLYE.SeqLength.csv

