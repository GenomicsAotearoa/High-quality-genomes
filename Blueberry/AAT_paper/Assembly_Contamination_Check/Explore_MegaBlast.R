library(tidyverse)
library(gridExtra)
library(purrr)

options(warn = 1)

wkdir <- "/powerplant/workspace/hrasrb/Blueberry_trio/2023-09-01_remove_contamination/2023-09-07_chloro_blast"

setwd(wkdir)

myFiles <- list.files(pattern="*_reciprocal_blast.txt")

blast_cols <- c("qseqid", "staxids", "bitscore", "std", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue")

BLAST.df <- read_delim(myFiles, id = "filename", delim = '\t', comment = "#", col_names = blast_cols)
BLAST.df <- BLAST.df %>% mutate(filename=basename(filename))

# Edit the filename to just have the first part
BLAST.df <- separate(BLAST.df,
                        filename,
                        sep = ".noContamination.",
                        c("Tag", NA))
BLAST.df <- BLAST.df %>% unite("Tag_qseqid", Tag:qseqid, remove = FALSE)

files <- dir_ls(wkdir, glob = "*.chloro_hits.fa.fai")
coords.df <- read_delim(files, id = "filename", delim = '\t', comment = "#", col_names = c("contig_ID", "qlen", "x1", "x2", "x3"))
coords.df <- coords.df %>% mutate(filename=basename(filename))

# Edit the filename to just have the first part
coords.df <- separate(coords.df,
                      filename,
                     sep = ".noContamination.",
                     c("assembly", NA))

head(coords.df)
coords.df <- coords.df[,c(1:3)]
coords.df <- coords.df %>% unite("Tag_qseqid", assembly:contig_ID, remove = TRUE)
head(coords.df)

BLAST.df <- left_join(BLAST.df, coords.df, by = "Tag_qseqid")
rm(coords.df)

BLAST_props.df <- BLAST.df %>% 
  mutate(prop = length/qlen,
          .by = qseqid)

ggplot(BLAST_props.df, aes(x = prop)) +
  theme_bw() +
  geom_histogram() +
  scale_x_continuous(limits = c(0.0, 1.1), oob = scales::oob_keep) +
  theme(plot.title = element_text(size = 10))
summary(BLAST_props.df$prop)

BLAST_props_remove.df <- filter(BLAST_props.df, prop < .5)
BLAST_props.df <- filter(BLAST_props.df, prop >= .5)
# write.csv(BLAST_props.df, file = "Blueberry_chloro_hits_reciprocal_blast.csv", row.names = FALSE)
BLAST_props.df %>% group_by(Tag) %>% summarise(total_len = sum(length))
