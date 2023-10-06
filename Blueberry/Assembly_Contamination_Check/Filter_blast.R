library(tidyverse)
library(gridExtra)
library(purrr)

options(warn = 1)

wkdir <- "/powerplant/workspace/hrasrb/Blueberry_trio/2023-09-01_remove_contamination/2023-09-07_chloro_blast"

setwd(wkdir)

myFiles <- list.files(pattern="*.chloro_hits_nt_blast.txt")

blast_cols <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore", "qlen")

##################################################################################################################################
####################### PLOTTING #################################################################################################
##################################################################################################################################

plot.list = lapply(myFiles, function(file) {
  BLAST.df = read_delim(file, delim = "\t", col_names = blast_cols, show_col_types = FALSE)
  BLAST.df <- BLAST.df %>% filter(evalue == 0)
  BLAST.df <- BLAST.df %>% filter(pident >= 90)
  BLAST.df <- BLAST.df %>% filter(length >= 100)
  
  correctNoRows <- nrow(BLAST.df %>%  group_by(qseqid) %>% summarise(total_length = sum(length)))
  
  BLAST.df <- BLAST.df %>% 
    reframe(total_length = sum(length),
            prop = total_length/qlen,
            .by = qseqid)
  
  BLAST.df <- BLAST.df[!duplicated(BLAST.df$qseqid), ]
  
  noRows <- nrow(BLAST.df)
  
  print(identical(correctNoRows, noRows))
  
  ggplot(BLAST.df, aes(x = prop)) +
    theme_bw() +
    geom_histogram() +
    scale_x_continuous(limits = c(0.0, 1.0), oob = scales::oob_keep) +
    ggtitle(file) +
    theme(plot.title = element_text(size = 10))
})

# Lay out all the plots together
do.call(grid.arrange, plot.list) 


##################################################################################################################################
####################### GET CONTIGS ##############################################################################################
##################################################################################################################################


paths <- list.files(wkdir, pattern = "[.]chloro_hits_nt_blast.tsv$", full.names = TRUE)


process_file <- function(path) {
  df <- read_delim(path, delim = "\t", col_names = blast_cols, show_col_types = FALSE)
  
  df |> 
    filter(evalue == 0,
           pident >= 90,
           length >= 100) 
}

Res.df <- paths |> purrr::set_names(basename) |>
  map(process_file) |>
  list_rbind(names_to = "haplotype") 

tail(Res.df)

Res.df <- Res.df %>% 
  group_by(haplotype, qseqid, qlen) %>% 
  reframe(total_length = sum(length),
          prop = total_length/qlen)

Res.df <- Res.df %>% filter(prop >= 0.5)
Res.df <- distinct(Res.df)
write.csv(Res.df, file = "Blueberry_chloro_hits_nt_blast.csv", row.names = FALSE)

