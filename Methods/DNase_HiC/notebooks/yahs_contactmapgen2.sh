#!/bin/bash

##########################################################
### MODIEFIED FROM:  https://github.com/c-zhou/yahs/blob/v1.2a/scripts/run_yahs.sh
##########################################################

### Define variables ######
#out=CK69_01_v2.scaffolds_HiC8_yahs2 # Name of outfiles
#contigs="./RefGenome/CK69_01_v2.scaffolds.fasta" # 
#hicaln="CK69_01_v2.scaffolds_HiC8_yahs2.bin" ##  .bin file produced by YAHS

### Load conda environment #####
module load conda
module load samtools
conda activate hraijc_yahs


cd ${wkdir}
echo ${wkdir}
date

## need juicer_tools/pretextmap and samtools if want to do hic plot
## juicer_tools: https://github.com/aidenlab/juicer/wiki/Download
## PretextMap: https://github.com/wtsi-hpag/PretextMap
## PretexSnapshot: https://github.com/wtsi-hpag/PretextSnapshot
## samtools: https://github.com/samtools/samtools
## please adjust the path to juicer_tools and samtools
## here we use 12 CPUs and 24Gb memory for juicer_tools pre - adjust it according to your device
## see more information for juicer tools https://github.com/aidenlab/juicer/wiki/Juicer-Tools-Quick-Start
## output file will be ${out}.hic
## the output hic file could be viewed with JuiceBox https://github.com/aidenlab/Juicebox

## v1.9.9 seems much faster than v1.22.01
juicer_tools="java -Xmx24G -jar /workspace/hraijc/git_clones/juicer_tools.1.9.9_jcuda.0.8.jar pre"
# pretext_map="PretextMap"
# pretext_snapshot="PretextSnapshot"
samtools="samtools"


#### this is to generate input file for juicer_tools - non-assembly mode or for PretextMap
samtools faidx ${contigs}
## here we use 8 CPUs and 24Gb memory for sorting - adjust it according to your device
(/workspace/hraijc/git_clones/yahs/juicer pre ${out}.bin ${out}_scaffolds_final.agp ${contigs}.fai 2>${out}_tmp_juicer_pre.log | LC_ALL=C sort -k2,2d -k6,6d -T ${outdir} --parallel=8 -S24G | awk 'NF' > ${out}_alignments_sorted.txt.part) && (mv ${out}_alignments_sorted.txt.part ${out}_alignments_sorted.txt)
## prepare chromosome size file from samtools index file
cat ${out}_tmp_juicer_pre.log | grep "PRE_C_SIZE" | cut -d' ' -f2- >${out}_scaffolds_final.chrom.sizes
# ## do juicer hic map
# (${juicer_tools} ${out}_alignments_sorted.txt ${out}.hic.part ${out}_scaffolds_final.chrom.sizes) && (mv ${out}.hic.part ${out}.hic)
# ## do Pretext hic map
# (awk 'BEGIN{print "## pairs format v1.0"} {print "#chromsize:\t"$1"\t"$2} END {print "#columns:\treadID\tchr1\tpos1\tchr2\tpos2\tstrand1\tstrand2"}' ${out}_scaffolds_final.chrom.sizes; awk '{print ".\t"$2"\t"$3"\t"$6"\t"$7"\t.\t."}' ${out}_alignments_sorted.txt) | ${pretext_map} -o ${out}.pretext
# # and a pretext snapshot
# ${pretext_snapshot} -m ${out}.pretext --sequences "=full" -o ${outdir}

#### this is to generate input file for juicer_tools - assembly (JBAT) mode (-a)
/workspace/hraijc/git_clones/yahs/juicer pre -a -o ${out}_JBAT ${out}.bin ${out}_scaffolds_final.agp ${contigs}.fai 2>${out}_tmp_juicer_pre_JBAT.log
cat ${out}_tmp_juicer_pre_JBAT.log | grep "PRE_C_SIZE" | cut -d' ' -f2- >${out}_JBAT.chrom.sizes
(${juicer_tools} ${out}_JBAT.txt ${out}_JBAT.hic.part ${out}_JBAT.chrom.sizes) && (mv ${out}_JBAT.hic.part ${out}_JBAT.hic)

#### this is to generate final genome assembly file after manual curation with JuiceBox (JBAT)
## the output assembly file after curation is ${out}_JBAT.review.assembly
## the final output is ${out}_JBAT.FINAL.agp and ${out}_JBAT.FINAL.fa
# ../juicer post -o ${out}_JBAT ${out}_JBAT.review.assembly ${out}_JBAT.liftover.agp ${contigs}

