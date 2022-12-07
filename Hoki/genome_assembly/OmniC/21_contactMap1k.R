library(dplyr)
library(data.table)
workDir="C:\\oldD\\2021\\Fish"
setwd(workDir)

inFile="HH_HiC200M.mapped.PT.contact_map_1k_qualFilt.txt"
contactMap1K <-fread(inFile, nThread = 1, sep = "\t") %>% .[, .(n = sum(V5)), by = .(V1, V2, V3, V4)] %>% setnames(., c("V1", "V2","V3", "V4"), c("rname", "pos", "mrnm", "mpos")) %>% filter(n > 1)


saveRDS(contactMap1K, file = "HH_HiC200M.mapped.PT.contact_map_1k_qualFilt.rds")

## Now use Ali's HiC tool on:
## * HH_HiC200M.mapped.PT.contact_map_1k_qualFilt.rds
## * Mno_genome.FLYE.SeqLength.csv
## Move them to /output for other to run Ali's tool
## mv Mno_genome.FLYE.SeqLength.csv HH_HiC200M.mapped.PT.contact_map_1k_qualFilt.rds /output/genomic/fish/Macruronus/novaezelandiae/Assembly/OmniC/

#open the server file from Rstudio:
/workspace/hrpazs/petunia_genome/HiC/HicTool/server.R

# then run the R script to open the URL??
