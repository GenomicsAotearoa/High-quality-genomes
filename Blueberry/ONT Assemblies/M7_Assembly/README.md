# M7_Assembly
- Experiment No 10871
- ANU number Quote Number: Q-20210728
- PI: David
- Scientist:  Sara, Toshi
- Lab scientist: Elena Hilario, Iggy
- Bioinformaticians:    Iggy
- Species: Vaccinium corymbosum
- Ploidy: tetraploid 
- Tissue:  fully developed leaves
- Varietal: Hortblue Petite (M7)
- Sample type: nuclear genomic DNA  >50 kbp
- Platform: Oxford Nanopore PromethION FLOPRO111 R10 flowcell.
- Library: (Q20+) Library Prep SQK-Q20EA
- Date downloaded: 2022-01-17

## Background
* ONT PromethION RUN at ANU using Q20 Kits

## Data sources
- ANU DATA HERE: `/input/genomic/plant/Vaccinium/corymbosum/20220104_M7/20220104_1231_1A_PAI49175_9725852c/fast5_pass`
  - ANU did the basecalling with GuppyV5 sup accuracy. Run report here: `/input/genomic/plant/Vaccinium/corymbosum/20220104_M7/20220104_1231_1A_PAI49175_9725852c/report_PAI49175_20220104_1236_9725852c.pdf`

### Run info:
* Flow Cell Type FLO-PRO112
* Kit SQK-Q20EA

## Methods

### Code
- [Genomics Aotearoa High Quality Genomes GitHub](https://github.com/GenomicsAotearoa/High-quality-genomes/tree/main/Blueberry/M7_Assembly)
  

### Workflow
* Redo basecalling with GuppyV6
* Remove short and low quality reads
* Assemble with different Quality cutoffs and parameters in Flye and HiFiAsm.
* Pick the best assembly and purge duplicate haplotypes to get haploid genome assembly.

## Outputs
* Work in progress Illumina data will be here soon so should do read polishing and update assembly when it comes in.
* Best assembly using this data is here: `/output/genomic/plant/Vaccinium/corymbosum/2021_GenomeAssembly/M7/`

| Version 	| Assembly               	| Assembler 	| Param    	| Input Data Filter 	| Read_Coverage 	| n_scaffolds 	| scaf_bp     	| scaf_N50 	| scaf_L50 	| scaf_N90 	| scaf_L90 	| scaf_max 	| BUSCO                                          	|
|---------	|------------------------	|-----------	|----------	|-------------------	|---------------	|-------------	|-------------	|----------	|----------	|----------	|----------	|----------	|------------------------------------------------	|
| V1.0    	| M7_all_Flye_purge_Haps 	| Flye      	| nano-hq  	| Q>10              	| 40            	| 4,861       	| 777,074,663 	| 704      	| 314455   	| 2732     	| 72627    	| 2221956  	| C:95.9%[S:67.2%,D:28.7%],F:1.2%,M:2.9%,n:2326  	|