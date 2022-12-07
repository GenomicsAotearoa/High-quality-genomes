## Run HiCSuite with Ali


## now create fasta
## inputDir/ must contain files with name like group$N.ordering
## $N starts from 0
inputDir=/workspace/hrachd/Fish/2021/HiC/11_200M_data/HiCSuite/HiCSuiteGroups

## OUTPUT_DIR; must have a subdirectory main_results/ containig a file clusters.by_name.txt and a file group*.ordering for each group

genome=/output/genomic/fish/Macruronus/novaezelandiae/Assembly/Mno_genome.FLYE.PILON.noBac.fasta
outputDir=`pwd`
outChrsFasta=hoki.Chrs.fa

#perl /workspace/hrachd/hrachd/GitHub/Other/HiCSuite/inst/scripts/CreateScaffoldedFasta.pl $genome $inputDir $outputDir $outChrsFasta > LOG.CreateScafFasta.log 2>LOG.CreateScafFasta.err

## non-anchored
perl /workspace/hrachd/tools/extract_fasta_seqs_with_list.pl -f=$genome -l=non-anchored.IDs -o=hoki.nonAnchored.contigs.fa

cat $outChrsFasta hoki.nonAnchored.contigs.fa > hoki.chrsAndUnAnchoredSeqs.fa

module load samtools 
samtools faidx hoki.chrsAndUnAnchoredSeqs.fa

## move to /output
outDir=/output/genomic/fish/Macruronus/novaezelandiae/Assembly/Chrs
mv *.fa *.txt *.fai $outDir/
