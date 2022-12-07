#hap2 ragtag:
# Chr07 is wrong. Super short. 242kb
# Chr02 super long (588MB). Covers both chr02 and chr07 in NCBI.

#module load ragtag/1.0.2

## Fix 1: Chr07
baseDir=/workspace/hrachd/Gillenia/2022/INRAE/hap2
workDir=$baseDir/FixChr07
logDir=$workDir/.log
mkdir -p $logDir

cd $workDir
ncbiFa=/workspace/hrachd/Gillenia/2022/INRAE/GilleniaNCBI.chrs.fa
echo Chr07 > tmp.NCBIChr07.id
refGenome=NCBI_chr07.fa
perl /workspace/hrachd/tools/extract_fasta_seqs_with_list.pl -f=$ncbiFa -l=tmp.NCBIChr07.id -o=$refGenome

### best alignments are h2tg000013l and h2tg000030l
echo h2tg000013l > tmp.hap2.ids
echo h2tg000030l >> tmp.hap2.ids
hap2=/workspace/hrachd/Gillenia/2022/INRAE/Gilemnia_1CCS.HiFiasm.hap2.fasta
qryGenome=hap2.Chr07tigs.fa
perl /workspace/hrachd/tools/extract_fasta_seqs_with_list.pl -f=$hap2 -l=tmp.hap2.ids -o=$qryGenome

## ragtig
thread=10
bsub -m wkoppb30 -R "span[hosts=1]" -n $thread -o $logDir/Chr07.rag.log -e $logDir/Chr07.rag.err -J Chr07 "ragtag.py scaffold -r -o hap2Chr07 -t $thread $refGenome $qryGenome"

## alignment and telomere check
module load MUMmer/3.23
refGenome=/workspace/hrachd/Gillenia/2022/INRAE/hap2/FixChr07/NCBI_chr07.fa
qry=/workspace/hrachd/Gillenia/2022/INRAE/hap2/FixChr07/hap2Chr07/ragtag.scaffolds.fasta
cd /workspace/hrachd/Gillenia/2022/INRAE/hap2/FixChr07/hap2Chr07
bsub -m wkoppb30 -o $logDir/Chr07.nucmer.log -e $logDir/Chr07.nucmer.err -J Chr07 "nucmer -o --coords -p hap2Chr07 $refGenome $qry"

delta-filter -i 90 -l 5000 -q -r hap2Chr07.delta > hap2Chr07.I90L5K.delta
mummerplot --large --png hap2Chr07.I90L5K.delta -title hap2Chr07.I90L5K --prefix hap2Chr07.I90L5K

## telomere
bsub -m wkoppb30 -o $logDir/Chr07.tele.log -e $logDir/Chr07.tele.err -J Chr07T "/workspace/hraijc/git_clones/telomeric-identifier/target/release/tidk search -s TTAGGG --fasta $qry --output hap2Chr07_100K --window 100000"

/workspace/hraijc/git_clones/telomeric-identifier/target/release/tidk plot -h 120 -w 800 -c search/hap2Chr07_100K_telomeric_repeat_windows.csv -o hap2Chr07.telomerics


