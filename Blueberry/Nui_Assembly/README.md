# Nui_ONT_Assembly
 
Experiment Requestor: CAGRF21436
AGRF experiment number: 10719
PI: David
Scientist:  Susan, Toshi and Sara
Lab scientist: Elena Hilario
Bioinformatician:   Susan, Chen, Cecilia, Iggy
Species: Vaccinium corymbosum (parent of mapping popn)
Ploidy: tetraploid 
Tissue:  fully developed leaves
Varietal: Nui
Sample type: nuclear genomic DNA  >50 kbp
Data type: long read DNA
Library:   most likely SQK-LSK109 but it would be good to confirm with AGRF
Platform: Oxford Nanopore PromethION  and also keep track of the flow cell version, although not sure it comes with the metadata of the results
Date downloaded: 08-04-2020
 
## Background
Genomics Aotearoa project for assembling tetraploid genomes. This ONT data complements the capture-seq, 10X Chromium data, plus some RNAseq done in Filling the Void project. We have collaborations with USDA VacCAP project. The specimen is also parent of the mapping population used in Filling the Void and Growing Future Traits for Life Indoor.

## Data sources

- HiC Data for Nui is here:
    - /input/genomic/plant/Vaccinium/corymbosum/AGRF_CAGRF21434_HJWHFDRXX

- 10X data for Nui and M7 here:
    - /input/genomic/plant/Vaccinium/corymbosum/AGRF_CAGRF18813_H7JY3DRXX

- ONT PromethION Nui (BB2020 and BB2020-2 are the same sample) here:
    - /input/genomic/plant/Vaccinium/corymbosum/Blueberry_PromethION_Apr2020

- ONT MinION Nui (BB2020) here:
    - /input/genomic/plant/Vaccinium/corymbosum/CAGRF21436/20200224_MinION/AGRF_CAGRFF21436_FAL87845_BB2020/

## Method

- https://github.com/GenomicsAotearoa/High-quality-genomes/tree/main/Blueberry/Nui_Assembly/

### V1.0
- base-calling for ONT samples using Guppy v5.
- Filter out MinION reads <1kb.
- Cecilia has done the Supernova assembly for the 10X data.
- Use Flye to assemble ONT fastq
- Use quickmerge to merge the Supernova contigs + ONT contigs
- Use Salsa to improve assembly scaffolding
- Synteny Plots using Dgenies


## Results
 - See contiguity and completeness stats of assembly methods here: /workspace/hraijc/Blueberry/BB_Nui_Assembly/2021_Nui_Assembly_Stats.xlsx 
 - Several Flye assemblies were done using different filters for input data. Best results were obtained by filtering ONT reads with quality scores <10 and read lengths >5kb. This method of filtering removed about 50% of the reads. The assembly can be found here: /workspace/hraijc/BB_Nui_Assembly/ONT_Assemly/FLYE04/Flye04_assembly.fasta 
- The Flye assembly was merged with the Supernova assembly using quickmerge. Several combinations of query and reference assemblies were trialled as recommended in the quickmerge manual. The hybrid assemblies were only marginally better than the Flye assemblies. Due to the risk of mis-joining contigs from the assemblies, these hybrid assemblies were not used in the next steps. 
- Salsa was used to improve the scaffolding of the Flye04 assembly using the HiC data from this sample. Three iterations were done and this significantly improved the final assembly labelled Nui_Salsa02.

| Version 	|      filename     	| n_scaffolds 	| n_contigs 	|    scaf_bp    	|   contig_bp   	| gap_pct 	| scaf_N50 	| scaf_L50 	| ctg_N50 	| ctg_L50 	| scaf_N90 	| scaf_L90 	| ctg_N90 	| ctg_L90 	|  scaf_max 	|  ctg_max  	| scaf_n_gt50K 	| scaf_pct_gt50K 	|  gc_avg 	|  gc_std 	|                     Busco                     	|
|---------	|:-----------------:	|:-----------:	|:---------:	|:-------------:	|:-------------:	|:-------:	|:--------:	|:--------:	|:-------:	|:-------:	|:--------:	|:--------:	|:-------:	|:-------:	|:---------:	|:---------:	|:------------:	|:--------------:	|:-------:	|:-------:	|:---------------------------------------------:	|
| V1.0    	| Nui_Salsa02.fasta 	| 14,416      	| 18,956    	| 1,806,273,865 	| 1,804,003,865 	| 0.126   	| 1,908    	| 287,852  	| 2,304   	| 212,633 	| 6,633    	| 69,878   	| 9,146   	| 47,182  	| 2,121,296 	| 2,121,296 	| 7,615        	| 93.226         	| 0.38687 	| 0.03994 	| C:97.0%[S:12.6%,D:84.4%],F:0.8%,M:2.2%,n:2326 	|


## ToDO
- Plan to redo this assembly for V1.1 by:
    - Redoing the Basecalling with GuppyV6
    - Not merging the assembly with Quickmerge.
    - Pick the best Flye assembly.
    - Run Purge_Duplicates to create haploid assembly.
    - Run YAHS to do HiC scaffolding on the haploid assembly.