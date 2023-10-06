library(ggplot2)
library(magrittr)

wkdir <- "/powerplant/workspace/hrasrb/Blueberry_trio/2023-09-01_remove_contamination/2023-09-07_chloro_blast"
setwd(wkdir)

file="Blueberry_chloro.csv"
BLAST.df = read_csv(file, col_names = TRUE, show_col_types = FALSE)

ggplot(BLAST.df, aes(x = qlen)) +
  theme_bw() +
  geom_histogram() +
  facet_grid(haplotype~.) +
  theme(text = element_text(size = 10))

BLAST.df %>% group_by(haplotype) %>% summarise(sumLen = sum(qlen))
