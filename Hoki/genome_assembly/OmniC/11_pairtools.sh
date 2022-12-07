assembly=/output/genomic/fish/Macruronus/novaezelandiae/Assembly/Mno_genome.FLYE.PILON.noBac.fasta
genome=Hoki_Mno.fasta
faiFile=$genome'.fai'
genomeFile=Hoki_Mno.genome
genomeDir=/workspace/hrachd/Fish/2021/HiC/00_genome
referenceGenome=$genomeDir/$genome
thread=10
tmpDir=/workspace/hrachd/tmp/hoki/m200test
#mkdir -p $tmpDir
m2R1=HH_HiC200M_R1.fastq
m2R2=HH_HiC200M_R2.fastq
samFile=HH_HiC200M.sam
workDir=/workspace/hrachd/Fish/2021/HiC/11_200M_data
logDir=$workDir/.log


parseFile=HH_HiC200M.parse
pairsFile=HH_HiC200M.pairs
dedupFile=HH_HiC200M.dedup
statsFile=HH_HiC200M.stats
splitPairsFile=HH_HiC200M.split.pairs
splitSamFile=HH_HiC200M.split.sam

mappedFile=HH_HiC200M.mapped.PT.bam
preseqFile=HH_HiC200M.preseq

## Use Eric's latest installation
module load omni-c/04734cc

cd $workDir
#bsub -q priority -P P/952006/04 -o $logDir/02_bwa.log -e $logDir/02_bwa.err -J HH -n $thread "bwa mem -5SP -T0 -t $thread -o $samFile $referenceGenome $m2R1 $m2R2"
#Job <100930> is submitted to queue <priority>.

#bsub -q priority -P P/952006/04 -o $logDir/03_parse.log -e $logDir/03_parse.err -J parse -w 'done (100930)' -n $thread "pairtools parse --min-mapq 40 --walks-policy 5unique --max-inter-align-gap 30 --nproc-in $thread --nproc-out $thread --chroms-path $genomeDir/$genomeFile --output $parseFile $samFile"
#Job <100936> is submitted to queue <priority>.

#bsub -q priority -P P/952006/04 -o $logDir/04_pairs.log -e $logDir/04_pairs.err -J pairs -w 'done (100936)' -n $thread "pairtools sort --memory 20G --tmpdir=$tmpDir --nproc $thread --nproc-out $thread --output $pairsFile $parseFile"
#Job <100937> is submitted to queue <priority>.

#bsub -q priority -P P/952006/04 -o $logDir/05_dedup.log -e $logDir/05_dedup.err -J dedup -w 'done (100937)' -n $thread "pairtools dedup --nproc-in $thread --nproc-out $thread --mark-dups --output $dedupFile --output-stats $statsFile $pairsFile"
#Job <100938> is submitted to queue <priority>.


#bsub -q priority -P P/952006/04 -o $logDir/06_split.log -e $logDir/06_split.err -J split -w 'done (100938)' -n $thread "pairtools split --nproc-in $thread --nproc-out $thread --output-pairs $splitPairsFile --output-sam $splitSamFile $dedupFile"
#Job <100939> is submitted to queue <priority>.

#bsub -m aklppb34 -q priority -P P/952006/04 -o $logDir/07_sort.log -e $logDir/07_sort.err -J srt -n $thread "samtools view -bS -@ $thread $splitSamFile | samtools sort -@ $thread -o $mappedFile"
#Job <104598> is submitted to queue <priority>.

#bsub -q priority -P P/952006/04 -o $logDir/08_idx.log -e $logDir/08_idx.err -J Idx -w 'done (104598)' -n $thread "samtools index -@ $thread $mappedFile"
#Job <104599> is submitted to queue <priority>.


## Library QC
#get_qc.py -p $statsFile > HH_HiC200M.lib_qc.txt

## Library complexity
#bsub -q priority -P P/952006/04 -o $logDir/10_extrap.log -e $logDir/10_extrap.err -J extrap "preseq lc_extrap -bam -pe -extrap 2.1e9 -step 1e8 -seg_len 1000000000 -output $preseqFile $mappedFile"
#Job <104604> is submitted to queue <priority>.

## Contact matrix: .pairs to .hic
mapFile=HH_HiC200M.contact_map.hic

#bsub -n $thread -q priority -P P/952006/04 -o $logDir/11_jucer.log -e $logDir/11_jucer.err -J jucer -m aklppb34 "java -Xmx96000m  -Djava.awt.headless=true -jar /workspace/hrachd/tools/juicer_tools_1.22.01.jar pre --threads $thread $splitPairsFile $mapFile $genomeDir/$genomeFile"
#Job <106200> is submitted to queue <priority>.


## identify topologically assocaited domains (TADs)
## juicer_tools arrowhead [-c chromosome(s)] [-m matrix size] [-r resolution] [-k normalization (NONE/VC/VC_SQRT/KR)] [--ignore-sparsity flag] <hicFile(s)> <output_file> [feature_list] [control_list]



tadPath=$workDir/TADs
#bsub -n $thread -q priority -P P/952006/04 -o $logDir/12_tads.log -e $logDir/12_tads.err -J tads -m aklppb34 "java -Xmx96000m -Djava.awt.headless=true -jar /workspace/hrachd/tools/juicer_tools_1.22.01.jar arrowhead --threads $thread -k KR -m 2000 -r 10000 $mapFile $tadPath"
#Job <110240> is submitted to queue <priority>.
# Job killed as it's been pending but not started

java -Xmx96000m -Djava.awt.headless=true -jar /workspace/hrachd/tools/juicer_tools_1.22.01.jar arrowhead --threads 10 -k KR -m 2000 -r 10000 HH_HiC200M.contact_map.hic /workspace/hrachd/Fish/2021/HiC/11_200M_data/TADs > .log/13_tads.log 2>.log/13_tads.err &


more .log/13_tads.err
Warning: Hi-C map is too sparse to find many domains via Arrowhead.
Exiting. To disable sparsity check, use the --ignore-sparsity flag.


## only one TAD is found
java -Xmx96000m -Djava.awt.headless=true -jar /workspace/hrachd/tools/juicer_tools_1.22.01.jar arrowhead --threads 10 --ignore-sparsity -k KR -m 2000 -r 10000 HH_HiC200M.contact_map.hic /workspace/hrachd/Fish/2021/HiC/11_200M_data/TADs > .log/14_tads.log 2>.log/14_tads.err &

## try with other parameters
java -Xmx96000m -Djava.awt.headless=true -jar /workspace/hrachd/tools/juicer_tools_1.22.01.jar arrowhead --threads 10 --ignore-sparsity -k KR -m 2000 -r 5000 HH_HiC200M.contact_map.hic /workspace/hrachd/Fish/2021/HiC/11_200M_data/TADsR5K > .log/15_tads.log 2>.log/15_tads.err &

#### Principle component of the contact matrix
#### Test on the longest scaffold: scaffold_251_pilon_pilon (25,972,667 nts)
java -Xmx96000m -Djava.awt.headless=true -jar /workspace/hrachd/tools/juicer_tools_1.22.01.jar eigenvector -p KR HH_HiC200M.contact_map.hic scaffold_251_pilon_pilon BP 1000000 /workspace/hrachd/Fish/2021/HiC/11_200M_data/PCA/scaffold_251.txt > .log/16_pca.scaffold_251.log 2>.log/16_pca.scaffold_251.err &






