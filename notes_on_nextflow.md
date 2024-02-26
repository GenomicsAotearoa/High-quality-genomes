# Notes on nextflow/nf-core

## Strengths
- Active and friendly community (developers and users).
- Test data available to run pipeline in a couple of minutes.
- Results of real-life dataset (run on AWS) available for inspection and compute estimates.
- Troubleshooting facilitated by having each analysis step for each sample done in a separate folder that contains all input data, scripts and logs.
- Frequent updates.

## Weaknesses / traps
- No removal of intermediate files once they are no longer needed. The storage footprint per sample ballons. Here is an example:
  - raw fastq file
  - trimmed fastq file
  - mapped bam file
  - mapped, marked duplicates cram file
  - mapped, marked duplicates recalibrated cram files split
  - mapped, marked duplicates recalibrated cram files merged
- Results are copied from working folder to results folder, increasing the storage footprint. Files in results folder are not seen by cache.
- Documentation and code diverged
- Container solutions and multiple layers of symlinks cause friction if not all required folders are bound into the container environment (e.g. symlink location is visible but original file the symlink is pointing o is not).

- Save the reference files (indices) as early as possible. Deleting the indices invalidates all subsequent steps as recreated indices will have a different time stamp and therefore a different hashsums (despite the fact that they are identical i content).
- Slack vs GitHub. Slack is more for an interactive conversation, it does not provide ticketing and linking different posts about the same thing or pull requests on GitHub is tricky.
- No dry-run option
- Difficult to estimate progress.
  - No overall percent complete available
  - Percent complete per step changes as the pipeline becomes aware of more samples.

# Notes on premade all singing and dancing solutions
- If you want to do the same analysis as the original developers on the same species with a similar number of samples, no problem. If you deviate from that problems appear.
- Flacky bioinformatics software are the underpinning of workflows. If you are doing things differently (see above) you might encounter new bugs/limitations. Problems tend to be fixed via workarounds rather than addressing the (upstream) root cause.
- Solutions from different workflows are ripped out of context and reused.
- Lots of components and lots of options mean multiple levels of modules and config files. Trouble shooting becomes multi-layered and complicated. You end up just trying things not knowing what you are doing.

# Notes on large-scale analyses
- Compute is not really the bottleneck.
- First bottleneck is getting data to the compute location. "Streaming" data directly into analyses is risky because of network isssues. Staging all data for compute takes a long time and produces no results during that step.
  It is recommended to run the analysis in a way that accepts new samples and produces results continuously.
- 
