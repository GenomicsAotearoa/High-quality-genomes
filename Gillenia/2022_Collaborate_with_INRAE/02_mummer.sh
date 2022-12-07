module load MUMmer/3.23

## reference is chrs in NCBI submission
refGenome=GilleniaNCBI.chrs.fa

for hap in hap1 hap2
do
  qry='Gilemnia_1CCS.HiFiasm.'$hap'.fasta'
  bsub -m wkoppb30 -o .log/$hap'.nucmer.log' -e .log/$hap'.nucmer.err' -J $hap "nucmer -o --coords -p $hap $refGenome $qry"
done


## filter
for file in `ls *.delta`
do
   filtDelta=${file/delta/I90L5K.delta}
   delta-filter -i 90 -l 5000 -q -r $file > $filtDelta
done

## plot
for file in `ls *I90L5K.delta`
do
   title=${file/I90L5K.delta/Flt_vs_GilleniaNCBI}
   prefix=$title
   mummerplot --large --png $file -title $title --prefix $prefix
done

## Check h1tg000077l to Chr09 (which was joined to h1tg000008l to make Chr09 in ragtig. BUT h1tg000008l is alread fully covers the Chr09 (NCBI version)!
show-coords -c -d -o -r -T  hap1.I90L5K.delta > hap1.I90L5K.coords

# or:
hap1.coords | grep Chr09 > hap1.h1tg000077l_to_Chr09.coords
## all the alignments are small fragments with aligned length < 300
## Should NOT attach to h1tg000008l to make Chr09

## Chr02 has multiple contigs aligned to it at the same region (3')
## Check further
deltaFile=hap2.I90L5K.delta
testFile=tmp.hap2.contigsToChr02.I90L5K.delta

echo "/workspace/hrachd/Gillenia/2022/INRAE/hap2/FixChr02/NCBI_chr02.fa /workspace/hrachd/Gillenia/2022/INRAE/hap2/FixChr02/tmp.hap2.3contigs.fa" > $testFile
echo NUCMER >> $testFile 
perl -lane 'BEGIN {$ok=0;} if ($F[0] =~ m/>Chr02/ && ($F[1] eq "h2tg000009l" || $F[1] eq "h2tg000016l" || $F[1] eq "h2tg000020l")) {$ok = 1; print;} elsif (m/^>/) { $ok = 0;} elsif ($ok) {print;}' hap2.I90L5K.delta >> tmp.hap2.contigsToChr02.I90L5K.delta

mummerplot --large --png -title hap2tigsToChr02.I90L5K --prefix hap2tigsToChr02.I90L5K $testFile

