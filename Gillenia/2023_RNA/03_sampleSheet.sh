#!/usr/bin/env python

import pandas as pd

file_path = "/input/genomic/plant/Malus/domestica/RoyalGala/Transcriptome/ExperimentRequestor10986/metadata/MetaDatav2.1-ExpReq10986B.xlsx"
file_data = pd.read_excel(file_path, sheet_name="Samplesheet")

file_data.loc[:, "sample"] = file_data["sample_name"]
file_data.loc[:, "fastq_1"] = file_data["directory"] + "/" + file_data["file_name_F"]
file_data.loc[:, "fastq_2"] = file_data["directory"] + "/" + file_data["file_name_R"]
file_data.loc[:, "strandedness"] = "auto"

file_data = file_data[["sample", "fastq_1", "fastq_2", "strandedness"]]
file_data.to_csv("ER10986.sample_sheet.csv", index=False)
