# Notes on [nextflow](https://www.nextflow.io/)/[nf-core](https://nf-co.re/)

## Strengths
- Active and friendly community (developers and users).
- Test data available to run pipeline in a couple of minutes. However includes step that is known to fail on test data. Also test results are not available.
- Results of real-life dataset (run on AWS) available for inspection and compute estimates.
- Troubleshooting facilitated by having each analysis step for each sample done in a separate folder that contains all input data, scripts and logs.
- Frequent updates.
- Some pipelines allow different entry points (steps) and choice of tools.
- Execution trace shows what step for what sample was run in what folder and had what result.

## Weaknesses / traps
- No removal of intermediate files once they are no longer needed. The storage footprint per sample ballons. Here is an example:
  - raw fastq file
  - trimmed fastq file
  - mapped bam file
  - mapped, marked duplicates cram file
  - mapped, marked duplicates recalibrated cram files split
  - mapped, marked duplicates recalibrated cram files merged
- Results are copied from working folder to results folder, increasing the storage footprint. Files in results folder are not seen by cache.
- DAG visualization of larger workflows not working.
- Tool and parameter choice not explained and might not be appropriate. Within sarek none of the tools provide gVCF by default. Freebayes is designed to call variants in a population, sarek is doing it one sample at a time.
- Documentation and code diverged
- Container solutions and multiple layers of symlinks cause friction if not all required folders are bound into the container environment (e.g. symlink location is visible but original file the symlink is pointing o is not).
- Save the reference files (indices) as early as possible. Deleting the indices invalidates all subsequent steps as recreated indices will have a different time stamp and therefore a different hashsums (despite the fact that they are identical in content). Rerunning some samples with `-resume` triggers redoing alignments if the location of the indices changed.
- Slack vs GitHub. Slack is more for an interactive conversation, it does not provide ticketing and linking different posts about the same thing or pull requests on GitHub is tricky.
- No dry-run option
- Difficult to estimate progress.
  - No overall percent complete available
  - Percent complete per step changes as the pipeline becomes aware of more samples.
- While nextflow can respond in a very flexible way to all imaginable outcomes, results of a step need to be observed to determine the path, that means DAG can only be created after a run and there is no dry_run option.
- Apptainer is not just Singularity, the two diverged. Also by default apptainer (within nf-core) uses docker containers, not singularity containers.
- Use bgzip instead of gzip.
- Supply genome uncompressed.
- Samplesheet not straight forward. Patient, sample, lane are used differently from AgResearch.
- Failed jobs stop the complete pipeline (either immediately or after retrying with more resoures (if configured)). Setting this to `ignore` skips retries. Maybe one can via exitcode distinguish between running out of resoures and failing and take appropriate action.

# Notes on premade all singing and dancing solutions
- If you want to do the same analysis as the original developers on the same species with a similar number of samples, no problem. If you deviate from that problems appear.
- Flacky bioinformatics software are the underpinning of workflows. If you are doing things differently (see above) you might encounter new bugs/limitations. Problems tend to be fixed via workarounds rather than addressing the (upstream) root cause.
- Solutions from different workflows are ripped out of context and reused.
- Lots of components and lots of options mean multiple levels of modules and config files. Trouble shooting becomes multi-layered and complicated. You end up just trying things not knowing what you are doing.
- For sarek not having your species on igenomes makes things more difficult. Indices for VQSR are not computed but need to be supplied, different for the genome. NFCORE_SAREK:SAREK:CRAM_SAMPLEQC:BAM_NGSCHECKMATE:BCFTOOLS_MPILEUP can't use `--ploidy GRCh37` and ends up haploid.

# Notes on large-scale analyses
- Compute is not really the bottleneck.
- First bottleneck is getting data to the compute location. "Streaming" data directly into analyses is risky because of network isssues. Staging all data for compute takes a long time and produces no results during that step.
  It is recommended to run the analysis in a way that accepts new samples and produces results continuously.
- Convenient listing of commands used no longer shown in reports file if list too long.
