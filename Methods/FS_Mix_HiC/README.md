# Testing FS_Mix digested Hi-C libraries
### Team:
- Lead + Labwork: Elena Hilario
- Support + Bioinformatics: Ignacio Carvajal

## Objective:
- The NEBNext Ultra II FS DNA Module converts intact DNA into fragmented, end-repaired DNA having 5´ phosphorylated, 3´ dA-tailed ends. [NEB Website](https://www.neb.com/en-nz/products/e7810-nebnext-ultra-ii-fs-dna-module)
- We would like to use this enzyme for creating Hi-C libraries that are comparable to DNase digested libraries (Omni-C). [DNAse Hi-C lib prep protocol](https://www.protocols.io/view/enzymatic-fragmentation-of-plant-chromatin-for-hi-j8nlk4pnxg5r/v1)
- The FS_Mix digestion is much easier to control compared to DNase as it is an endpoint reaction, no titration or time calibration of enzymes necessary. It also does the end repair and dA tailing all in one step, saving time and cleanup steps. 
- This experiment was designed to ensure that FS-Mix Hi-C libraries were comparable to DNase Hi-C libraries. Specifically we will check if there is any site specificity to the FS_Mix cutting and if the normal Hi-C QC metrics are comparable. 

### Experimental setup:
One *Actinidia chinensis* plant was used as a control and 4 libraries were created from this material after isolating nuclei:
1) DNase digested Hi-C Library following the protocols.io link. This is our Control sample.
2) FS_Mix digested Hi-C Library. Digestion time = 1 Hour
3) FS_Mix digested Hi-C Library. Digestion time = 2 Hour
4) FS_Mix digested Hi-C Library. Digestion time = 3 Hour

DNase Library was sequenced on a Novaseq lane in 2024 and the FS_Mix libraries were sequenced on an MGI G99 20M flowcell. The DNAse library was subsampled down to 7M read pairs to match the read depth of the FS_mix libraries. 

[For Fragment analyzer traces and lab notes see here](Methods/FS_Mix_HiC/FS_mix_digest_tests.pdf) 

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
- [See Multiqc output](Methods/FS_Mix_HiC/Results/MultiQC_Report.pdf)
- [See deeptools coverage plot](Methods/FS_Mix_HiC/Results/fingerprint_comparison.plotFingerprint.pdf)

| Sample   | % of RP > 10KB apart | Informative  Reads / contig / 1M Reads | % Informative | % Non Informative | % Duplicate | % Mapq=0 | % Unmapped |
|----------|----------------------|----------------------------------------|---------------|-------------------|-------------|----------|------------|
| Yeast Restriction Enzyme Library for comparison | 4                    | 2500                                   | 12.4          | 24.4              | 0.15        | 15       | 4.8        |
| FS   1H  | 6.4                  | 4309                                   | 22            | 18.8              | 7.46        | 5.4      | 0.9        |
| FS 2H    | 9.1                  | 5769                                   | 28.5          | 16.83             | 5.52        | 5.69     | 0.58       |
| FS   3H  | 13.4                 | 7661                                   | 37.4          | 14.3              | 2.18        | 6.23     | 0.53       |
| DNAse    | 16.81                | 8267                                   | 40.54         | 16.09             | 1.03        | 7.98     | 0.56       |

- FS_mix digested Hi-C libraries are comparable to DNase digested Hi-C libraries in coverage eveness and hicqc metrics when digested for 3 hours. 