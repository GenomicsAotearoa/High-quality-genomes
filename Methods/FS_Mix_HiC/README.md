# Testing FS_Mix digested Hi-C libraries
### Team:
- Lead + Labwork: Elena Hilario
- Support + Bioinformatics: Ignacio Carvajal

## Objective:
- The NEBNext Ultra II FS DNA Module converts intact DNA into fragmented, end-repaired DNA having 5´ phosphorylated, 3´ dA-tailed ends. [NEB Website](https://www.neb.com/en-nz/products/e7810-nebnext-ultra-ii-fs-dna-module)
- We would like to use this enzyme for creating Hi-C libraries that are comparable to DNase I digested libraries (Omni-C). [DNase I Hi-C lib prep protocol](https://www.protocols.io/view/enzymatic-fragmentation-of-plant-chromatin-for-hi-j8nlk4pnxg5r/v1)
- The FS_Mix digestion is much easier to control compared to DNase I as it is an endpoint reaction, no titration or time calibration of enzymes necessary. Additionally, it does the end repair and dA tailing all in one step, saving time and cleanup steps. 
- This experiment was designed to ensure that FS-Mix Hi-C libraries were comparable to DNase I Hi-C libraries. Specifically we will check if there is any bias in the FS_Mix cutting by checking for uniformity in the FS_Mix hi-c data. We will also check the normal Hi-C QC metrics. 

### Experimental setup:
One *Actinidia chinensis* plant was used as a control and 4 libraries were created from this material after isolating nuclei:
1) DNase I digested Hi-C Library following the protocols.io link. This is our Control sample.
2) FS_Mix digested Hi-C Library. Digestion time = 1 Hour
3) FS_Mix digested Hi-C Library. Digestion time = 2 Hour
4) FS_Mix digested Hi-C Library. Digestion time = 3 Hour

DNase I Library was sequenced on a Novaseq lane in 2024 and the FS_Mix libraries were sequenced on an MGI G99 20M flowcell. The DNase I library was subsampled down to 7M read pairs to match the read depth of the FS_mix libraries. A yeast Hi-C library is added to some of the outputs to compare these libraries to one digested with restriction enzyme like in the yeast dataset. 


### Wet-Lab

[For Fragment analyzer traces and lab notes see here](FS_mix_digest_tests.pdf) 

### Analysis
[Analyzed with PairtoolsQC](https://github.com/PlantandFoodResearch/pairtoolsqc)


1. **Prepare assembly**: decompress if `.gz` (`GUNZIP`), then index (`SAMTOOLS_FAIDX`, `MINIBWA_INDEX`) and compute chromosome sizes (`CHR_SIZES`). [Samtools](https://github.com/samtools/samtools)
2. **Align**: map Hi-C reads with `MINIBWA_MAP` (`--hic` mode), then mark duplicates/flag with `SAMBLASTER`. [Minibwa](https://github.com/lh3/minibwa)  [Samblaster](https://github.com/GregoryFaust/samblaster)
3. **Hi-C QC**: run `HICQC` on the samblaster BAM. [Phase Genomics tool](https://github.com/phasegenomics/hic_qc)
4. **Coverage QC**: coordinate-sort and index the BAM (`SAMTOOLS_SORT`, `SAMTOOLS_INDEX`), then:
   - `DEEPTOOLS_PLOTFINGERPRINT` on all samples together (labelled by sample tag) [Deeptools](https://deeptools.readthedocs.io/en/develop/content/tools/plotFingerprint.html)
   - `MOSDEPTH` per sample (whole-genome, no BED file) [Mosdepth](https://github.com/brentp/mosdepth)
5. **Pairs processing**: `PAIRTOOLS_PARSE` → `PAIRTOOLS_SORT` → `PAIRTOOLS_DEDUP`.
6. **Report**: `MULTIQC` aggregates the pairtools parse/dedup stats and the mosdepth summary/global distribution files. [MultiQC](https://github.com/multiqc/multiqc)


## Results
- [See Multiqc output](Results/MultiQC_Report.pdf)
- [See deeptools coverage plot](Results/fingerprint_comparison.plotFingerprint.pdf)

| Sample   | % of RP > 10KB apart | Informative  Reads / 1M Reads | % Informative | % Non-Informative | % Duplicate | % Mapq=0 | % Unmapped |
|----------|----------------------|----------------------------------------|---------------|-------------------|-------------|----------|------------|
| Yeast Restriction Enzyme Library for comparison | 4                    | 2500                                   | 12.4          | 24.4              | 0.15        | 15       | 4.8        |
| FS   1H  | 6.4                  | 4309                                   | 22            | 18.8              | 7.46        | 5.4      | 0.9        |
| FS 2H    | 9.1                  | 5769                                   | 28.5          | 16.83             | 5.52        | 5.69     | 0.58       |
| FS   3H  | 13.4                 | 7661                                   | 37.4          | 14.3              | 2.18        | 6.23     | 0.53       |
| DNase I    | 16.81                | 8267                                   | 40.54         | 16.09             | 1.03        | 7.98     | 0.56       |

- The FS_mix 3H sample is comparable to DNase I digested Hi-C libraries in eveness of coverage and hi-c QC metrics and a significant improvement compared to libraries created using a restriction enzyme digest. 