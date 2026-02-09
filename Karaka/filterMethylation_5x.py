import pandas as pd
import numpy as np
import glob
import os

# === FIND ALL BED.GZ FILES ===
# Missing: What if no .bed.gz files exist?
bed_files = glob.glob("chr*_karaka_v1.primary.5mC_t90_C*.bed.gz")

colnames = [
    "Chromosome", "Start", "End", "Name", "Score", "Strand",
    "Start2", "End2", "Colour", "Coverage", "Percentage",
    "Modified", "Canonical", "other_mod", "delete", "fail", "diff", "nocall"
]

dtype_dict = {
    "Chromosome": str, "Start": int, "End": int, "Name": str, 
    "Score": float, "Strand": str, "Start2": int, "End2": int,
    "Colour": str, "Coverage": int, "Percentage": float,
    "Modified": int, "Canonical": int, "other_mod": int,
    "delete": int, "fail": int, "diff": int, "nocall": int
}

summary_records = []

for f in bed_files:
    print("="*80)
    print(f"Processing: {f}")
    print("="*80)

    # === TAG (remove .bed.gz) ===
    tag = os.path.basename(f).replace(".bed.gz", "")

    # === LOAD DATA ===
    print("Loading data...")
    methobj = pd.read_csv(f, sep="\t", compression="gzip", header=None,
                      names=colnames, dtype=dtype_dict, low_memory=False)
    print(f"Loaded {len(methobj):,} rows")

    # === CLEAN ===
    print("Dropping NA rows...")
    methobj.dropna(inplace=True)
    print(f"Remaining rows: {len(methobj):,}")

    # === FILTER COVERAGE ≥5 AND ≤100 ===
    methobj5 = methobj[(methobj["Coverage"] >= 5) & (methobj["Coverage"] <= 100)]
    del methobj
    methobj5["Score"] = methobj5["Score"].astype(int)
    
    # === Compute stats ===
    row_count = len(methobj5)
    mean_perc = methobj5["Percentage"].mean()
    sd_perc   = methobj5["Percentage"].std()

    # === Save filtered data ===
    output_file = f"{tag}_5x.bed"
    methobj5.to_csv(output_file, sep="\t", header=False, index=False)

    # === Add summary to list ===
    summary_records.append({
        "file": f,
        "tag": tag,
        "rows_after_filtering": row_count,
        "mean_percentage": round(mean_perc, 6),
        "sd_percentage": round(sd_perc, 6)
    })
    
    del methobj5
    
    print(f"Finished: {tag}\n")

# === CREATE SUMMARY TSV ===
summary_df = pd.DataFrame(summary_records)
summary_df.to_csv("methylation_summary.tsv", sep="\t", index=False)

print("All files processed successfully.")
print("Summary written to: methylation_summary.tsv")
