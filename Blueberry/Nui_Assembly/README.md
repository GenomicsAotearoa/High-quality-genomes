# Nui_ONT_Assembly_README

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

- All scripts and intermediate files here:
    - /workspace/hraijc/BB_Nui_Assembly/

## Plan 
- base-calling for ONT samples using Guppy v5.
- Filter out MinION reads <1kb.
- Cecilia has done the Supernova assembly for the 10X data.
- Use Flye to assemble ONT fastq
- Use quickmerge to merge the Supernova contigs + ONT contigs
- Use Salsa to improve assembly scaffolding

## Results
 - See contiguity and completeness stats of assembly methods here: /workspace/hraijc/BB_Nui_Assembly/2021_Nui_Assembly_Stats.xlsx 
 - Several Flye assemblies were done using different filters for input data. Best results were obtained by filtering ONT reads with quality scores <10 and read lengths >5kb. This method of filtering removed about 50% of the reads. The assembly can be found here: /workspace/hraijc/BB_Nui_Assembly/ONT_Assemly/FLYE04/Flye04_assembly.fasta 
- The Flye assembly was merged with the Supernova assembly using quickmerge. Several combinations of query and reference assemblies were trialled as recommended in the quickmerge manual. The hybrid assemblies were only marginally better than the Flye assemblies. Due to the risk of mis-joining contigs from the assemblies, these hybrid assemblies were not used in the next steps. 
- Salsa was used to improve the scaffolding of the Flye04 assembly using the HiC data from this sample. Three iterations were done and this significantly improved the final assembly labelled Nui_Salsa02.
