module load ragtag/1.0.2
thread=20

## chrs in our original Gillenia assembly submitted to NCBI
refGenome=GilleniaNCBI.chrs.fa

for hap in hap1 hap2
do
  qryGenome='Gilemnia_1CCS.HiFiasm.'$hap'.fasta'
  ## infer gap sizes (min 100, max 100000)
  bsub -m wkoppb30 -R "span[hosts=1]" -n $thread -o .log/$hap'.rag.log' -e .log/$hap'.rag.err' -J $hap "ragtag.py scaffold -r -o $hap -t $thread $refGenome $qryGenome"
done


## check
## hap1: 49 scaffolds placed and their sum is 290,303,029.
## Final is 220 scaffolds of 300943040, with gaps of 4000 bases
cd hap1
perl /workspace/hrachd/mytools/fastaStats.pl ragtag.scaffolds.fasta > ragtag.scaffolds.hap1.stats.txt &

## hap2: 36 scaffolds placed and their sum is 276,759,021. 
## Final is 110 scaffolds of 288848868, with gaps of 2700 bases.
cd ../hap2
perl /workspace/hrachd/mytools/fastaStats.pl ragtag.scaffolds.fasta > ragtag.scaffolds.hap2.stats.txt &
