# M7xNui_Assembly WORK IN PROGRESS
 
Experiment Requestor: 10871 and 10969
ANU number Quote Number: Q-20210728
Neogen Quote Number for PacBio: 00001079
PI: David
Scientist:  Sara, Toshi
Lab scientist: Elena Hilario, Iggy
Bioinformaticians:   Chen, Iggy
Species: Vaccinium corymbosum (progeny of Nui and Hortblue Petite (M7))
Ploidy: tetraploid 
Tissue:  Leaves from baby plant.
Varietal: Progeny of M7(Father) and Nui(Mother). V06.A002-186 ME44-049
Sample type: nuclear genomic DNA  >50 kbp
Sample Name in Lab: ONT_gDNA43_346_EH
Platform: Oxford Nanopore PromethION FLOPRO111 R10 flowcell.
Library: (Q20+) Library Prep SQK-Q20EA
Date downloaded: 2022-02-17
 
## Background
Genomics Aotearoa project for assembling tetraploid genomes. This work is mainly being done to identify the Anthocyanin QTL in LG2 for the Growing Future Traits for Life Indoors project. V1.0 of the genome was done using ONT Q20 data. V2.0 will be done using a triobinning approach by combining illumina data of the parents with PacBio HiFi data of the progeny. The goal is to have a fully phased tetraploid genome.

## Data sources

- ONT PromethION M7xNui here:
    - /input/genomic/plant/Vaccinium/corymbosum/20220208_M7xNui


## Method

- https://github.com/GenomicsAotearoa/High-quality-genomes/tree/main/Blueberry/M7xNui_Assembly

### V1.0
- base-calling for ONT samples using Guppy v6.
- Filter out MinION reads.
- Use Flye to assemble 


## Results
 - See contiguity and completeness stats of assembly methods here: /workspace/hraijc/Blueberry/BB_M7xNui_Assembly/99_Outputs/Assembly_Stats_M7xNui.xlsx 
 - Several Flye assemblies were done using different filters for input data. Best results were obtained by filtering ONT reads with quality scores <10 and read lengths >2kb. 


| Assembly          	| n_scaffolds 	| n_contigs 	| scaf_bp       	| contig_bp  	| gap_pct 	| scaf_N50 	| scaf_L50 	| ctg_N50 	| ctg_L50 	| scaf_N90 	| scaf_L90 	| ctg_N90 	| ctg_L90 	| scaf_max 	| ctg_max 	| scaf_n_gt50K 	| scaf_pct_gt50K 	| gc_avg  	| gc_std  	| Seq_Coverage 	| param   	| BUSCO                                         	| filename                                                                                 	|
|-------------------	|-------------	|-----------	|---------------	|------------	|---------	|----------	|----------	|---------	|---------	|----------	|----------	|---------	|---------	|----------	|---------	|--------------	|----------------	|---------	|---------	|--------------	|---------	|-----------------------------------------------	|------------------------------------------------------------------------------------------	|
| M7xNui_min2k_Flye 	| 16842       	| 16842     	| 1,745,824,185 	| 1745824185 	| 0       	| 2088     	| 234333   	| 2088    	| 234333  	| 8044     	| 53042    	| 8044    	| 53042   	| 2078196  	| 2078196 	| 8272         	| 90.673         	| 0.38486 	| 0.03066 	| 41           	| nano-hq 	| C:97.2%[S:11.6%,D:85.6%],F:0.6%,M:2.2%,n:2326 	| /powerplant/workspace/hraijc/BB_M7xNui_Assembly/03_FLYE/M7xNui_min2k_Flye/assembly.fasta 	|


## ToDO
- Plan to finish this assembly for V1.0 by:
  - Run Purge_Duplicates to create haploid assembly.
  - UPDATE: Abandoning V1.0.
- Plan for V2.0:
  - With HiFi data we will be doing a new assembly using a triobinning aproach with the illumina data from the parents of this cross.
  - This will be done on the pipeline being developed that will run two diploid assemblies on the HiFi reads binned by the parents.