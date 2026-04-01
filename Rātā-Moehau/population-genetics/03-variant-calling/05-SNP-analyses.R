## Analysing rata Moehau SNPs, adapted from Nat Forsdick Kuaka script by Jessie Prebble Oct 2024

## SNPRelate for PCA

if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
install.packages("tinytex")
BiocManager::install("gdsfmt")
BiocManager::install("SNPRelate")
BiocManager::install("gdsfmt")
BiocManager::install("MASS")
install.packages("pals")
install.packages("xfun")
install.packages("gridExtra")

library(gdsfmt)
library(SNPRelate)
library(MASS)
library(gridExtra)
library(scales) # allows use of alpha to change plot opacity

sessionInfo()
#as at 3/10/2023 = R version 4.4.1 (2024-06-14 ucrt)

citation("gdsfmt")

#Xiuwen Zheng, David Levine, Jess Shen, Stephanie M. Gogarten, Cathy Laurie, Bruce S. Weir. A
#High-performance Computing Toolset for Relatedness and Principal Component Analysis of SNP Data.
#Bioinformatics 2012; doi: 10.1093/bioinformatics/bts606

#Xiuwen Zheng, Stephanie M. Gogarten, Michael Lawrence, Adrienne Stilp, Matthew P. Conomos, Bruce S. Weir,
#Cathy Laurie, David Levine. SeqArray -- A storage-efficient high-performance data format for WGS variant
#calls. Bioinformatics 2017; doi: 10.1093/bioinformatics/btx145

citation("SNPRelate")

#Xiuwen Zheng, David Levine, Jess Shen, Stephanie M. Gogarten, Cathy Laurie, Bruce S. Weir. A
#High-performance Computing Toolset for Relatedness and Principal Component Analysis of SNP Data.
#Bioinformatics 2012; doi: 10.1093/bioinformatics/bts606

citation("MASS")

#Venables, W. N. & Ripley, B. D. (2002) Modern Applied Statistics with S. Fourth Edition. Springer, New
#York. ISBN 0-387-95457-0

##Colours##

selected_colours <- c("#009cbd", "#ebb700")
color.gradient <- function(x, colors=selected_colours, colsteps=100) {
  return( colorRampPalette(colors) (colsteps) [ findInterval(x,
                                                             seq(min(x),max(x), length.out=colsteps)) ] )
}
x <- c((1:100)^2)

selected_colours2 <- c("#009cbd","#ebb700")
color.gradient2 <- function(x, colors=selected_colours2, colsteps=10) {
  return( colorRampPalette(colors) (colsteps) [ findInterval(y,
                                                             seq(min(y),max(y), length.out=colsteps)) ] )
}
y <- c((1:50)^2)

mwlrcolsOG <- c("#009cbd", "#de7c00", "#b7db57", "#64a70b",  "#00c1d5", "#ebb700")

mwlrcols <- c("#64a70b", "#898a8d", "#009cbd","#ebb700")

#import_vcfs
vcf.strict <- "rata-moehau-only_VariantCalls_20x_coverage_0site_missing_maf0.0.bcf.recode_0.8LD_VariantCalls.vcf"
vcf.highmaf<- "rata-moehau-only_VariantCalls_20x_coverage_0site_missing_maf0.25.bcf.recode_0.8LD_VariantCalls.vcf"

showfile.gds(closeall=TRUE)
snpgdsVCF2GDS(vcf.strict, "vcf.strict.gds", method="biallelic.only")
snpgdsSummary("vcf.strict.gds")

showfile.gds(closeall=TRUE)
snpgdsVCF2GDS(vcf.highmaf, "vcf.highmaf.gds", method="biallelic.only")
snpgdsSummary("vcf.highmaf.gds")

#sanity_check
# Open the GDS file
genofile <- snpgdsOpen("vcf.strict.gds")
genofile <- snpgdsOpen("vcf.highmaf.gds")

head(genofile)

#get population information
pop_code <- scan("./Metrosideros/filtering/pop_codes_only2.txt",
                 what=character())
# Display the first six values
head(pop_code)

# Get sample id
sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))
length(sample.id)

population <- as.factor(pop_code)
pca <- snpgdsPCA(genofile, num.thread=4,autosome.only=F)

pca$sample.id
sample.id.filename <- sub(".*/","",pca$sample.id)

# if we can assume the order of sample IDs is as the same as population codes 
cbind(sample.id,sample.id.filename, pop_code)

# variance proportion (%)
pc.percent <- pca$varprop*100
head(round(pc.percent, 2))

# Make the data frame
tab <- data.frame(sample.id = pca$sample.id,
                  pop = as.factor(pop_code)[match(pca$sample.id, sample.id)],
                  EV1 = pca$eigenvect[,1],    # the first eigenvector
                  EV2 = pca$eigenvect[,2],    # the second eigenvector
                  stringsAsFactors = FALSE)
head(tab$sample.id)
tail(tab$sample.id)
head(tab$pop)
tail(tab$pop)

# Draw


png("PCA-portrait-attempt2-nolegend.png", width = 450, height = 600)
plot(tab$EV2, tab$EV1, col=alpha(mwlrcols[tab$pop],0.6), pch=19, cex=2, 
     xlab="PC 2", ylab="PC 1")
#legend("topleft", legend=levels(tab$pop), 
#       pch=19, cex = 2, col=mwlrcols[1:nlevels(tab$pop)])
dev.off()
tab


plot(tab$EV2, tab$EV1, col=alpha(mwlrcols[tab$pop],0.6), pch=19, 
     xlab="PC 2", ylab="PC 1")
legend("topleft", legend=levels(tab$pop), 
       pch=19, col=mwlrcols[1:nlevels(tab$pop)])
text(x=pca$eigenvect[,2], y=pca$eigenvect[,1], labels=sample.id.filename,pos=1, offset=-1)

lbls <- paste("PC", 1:5, "\n", format(pc.percent[1:5], 
                                      digits=2), "%", sep="")
pairs(pca$eigenvect[,1:5], col=alpha(mwlrcols[tab$pop],0.6), pch=19, labels=lbls)

lbls <- paste("PC", 1:2, "\n", format(pc.percent[1:2], 
                                      digits=2), "%", sep="")
pairs(pca$eigenvect[,1:2], col=alpha(mwlrcols[tab$pop],0.6), pch=19, labels=lbls)


#Parallel coordinates plot for the top principal components:

#datpop <- factor(pop_code)[match(pca$sample.id, sample.id)]
#parcoord(pca$eigenvect[,1:5], col=alpha(y[datpop],0.6))

#To calculate the SNP correlations between eigenvectors and SNP genotypes:

# Get chromosome index
##chr <- read.gdsn(index.gdsn(genofile, "snp.chromosome"))
#CORR <- snpgdsPCACorr(pca, genofile, eig.which=1:4)

#savepar <- par(mfrow=c(2,1), mai=c(0.45, 0.55, 0.1, 0.25))

#for (i in 1:2)
#{
#  plot(abs(CORR$snpcorr[i,]), ylim=c(0,1), xlab="",
#       ylab=paste("PC", i),
#       col=1:length(chr), pch="+")
#}

#Can also do Weir-Cockerham Fst


# Two populations: HCB and JPT #I'm going to try Ko and Un
flag <- pop_code %in% c("Ko", "Un")

samp.sel <- sample.id[flag]
pop.sel <- pop_code[flag]
v <- snpgdsFst(genofile, sample.id=samp.sel, population=as.factor(pop.sel),
               method="W&C84", autosome.only=F)

# Weir and Cockerham weighted Fst estimate
v$Fst 
# Weir and Cockerham mean Fst estimate
v$MeanFst    
summary(v$FstSNP)

#looks like very low levels of differentiation

## Adegenet


```{r adegenet}
install.packages("vcfR")
install.packages("adegenet")
library(vcfR)
library(adegenet)

x <- read.vcfR("rata-moehau-only_VariantCalls_20x_coverage_0site_missing_maf0.25.bcf.recode_0.8LD_VariantCalls.vcf", verbose=F)
y <- vcfR2genind(x, ploidy=2, return.alleles=TRUE)
names(y)

#pop_code <- scan("./corr-map2.txt",
                 what=character())
y@pop
y@pop <- as.factor(pop_code)
y@pop
```
#Now we have the inputs loaded and are begin testing the analysis. First let's max out our PCs and set 2 expected clusters. How do our individuals group?

```{r prelimDAPC, dev=c('pdf'), fig.path='figures-strict/', ppi=500, units="in", fig.height=7, fig.width=10}
grp <- find.clusters(y, max.n.= 10, n.pca=12, n.clust=3)
#head(grp$grp, 10)
grp$size
head(grp$grp)
table(pop(y), grp$grp)
dapc1 <- dapc(y,grp$grp, n.pca = 15, n.da= 3)

table.value(table(pop(y), grp$grp), col.lab=paste("inf", 1:3),
row.lab=paste("ori", 1:3))

scatter(dapc1, scree.da=FALSE, scree.pca=TRUE, posi.pca="topleft", legend=TRUE, solid=0.5, bg="white", col=mwlrcols, clab=0)

summary(dapc1)

# unfortunately there's no argument to dictate the individual labels for assignplot().
assignplot(dapc1)

compoplot(dapc1, posi="bottomright", txt.leg=paste("Cluster", 1:2), lab="", col=mwlrcols, xlab="individuals")
```


install.packages("hierfstat")
library("hierfstat")


pop<-genind2genpop(y)

dist.genpop(pop)
pop_dst<-dist(pop)
ind_dist<-dist(y)
is.euclid(ind_dist)
ind_dist
#k-means clustering

find.clusters(y)
find.clusters(y, max.n.clust = 12)# then chose 9 PCs to retain, then 3 clusters


dapc1<-dapc(y,grp$pop_code)# chose 8 PCs to retain, and 2 discriminant functions (has to be more than 1, one looks best)  
scatter(dapc1)

dapc2<-dapc(y)

scatter(dapc1, scree.da=FALSE, bg="white", pch=20, cell=0, cstar=0, col=mwlrcols, solid=.4,
       cex=3,clab=0, leg=TRUE, txt.leg=paste("Cluster",1:4))


##To make heterozygosity plots rather than homozygosity plots

#```{r plot_het, eval=FALSE}
# import het file
het <- read.csv("rata-moehau-het-calc.csv", header = TRUE)#added in columns for population codes and IDs
head(het)

# get popcodes - file with two columns - col 1 is sample IDs, col 2 is population code
#pop_code <- read.delim("./popmap.txt", header=FALSE)
#head(pop_code)

# add pop code to heterozygosity table - indiv IDs need to match 
#het.pop <- left_join(pop_code, het, by = join_by(V1 == INDV))
#het.pop <- na.omit(het.pop)
#head(het.pop)


# then do something like this but based on pop assignment (corrplot or map)
library(ggplot2)
library(dplyr)

#summary(het.pop)


pop.cols <- c("#64a70b", "#898a8d", "#009cbd","#ebb700")

# observed proportion heterozygous
het %>% group_by(POP) %>%
  summarise(
    count = n(),
    "Mean proportion observed heterozygosity" = mean(PropOHET, na.rm = TRUE),
    SD = sd(PropOHET, na.rm = TRUE),
    Median = median(PropOHET, na.rm = TRUE),
    IQR = IQR(PropOHET, na.rm = TRUE)
  )

pop.obs.het <- het %>%
  ggplot(aes(x=POP, y=PropOHET, color = POP)) + 
  geom_boxplot(outlier.shape=8,
               outlier.size=2) +
  ylim(0.3,0.6)+
  geom_jitter(aes(color = POP,  alpha=0.8), size=3) +
  theme_classic() +
  theme(legend.position = "none") + 
  labs(y= "Proportion of observed heterozygous SNPs")+
  scale_color_manual(values=pop.cols)+
  xlab("")

png("obs-Het.png", width = 800, height = 1200)
plot(pop.obs.het)
dev.off()



# expected proportion heterozygous

het %>% group_by(POP) %>%
  summarise(
    count = n(),
    "Mean proportion expected heterozygosity" = mean(PropEHET, na.rm = TRUE),
    SD = sd(PropEHET, na.rm = TRUE),
    Median = median(PropEHET, na.rm = TRUE),
    IQR = IQR(PropEHET, na.rm = TRUE)
  )

pop.exp.het <- het %>%
  ggplot(aes(x=POP, y=PropEHET, color = POP)) + 
  geom_boxplot(outlier.shape=8,
               outlier.size=2) +
  ylim(0.2,0.6)+
  geom_jitter(aes(color = POP,  alpha=0.8), size=3) +
  theme_classic() +
  theme(legend.position = "none") + 
  labs(y= "Proportion of expected heterozygous SNPs")+
  scale_color_manual(values=pop.cols)+
  xlab("")
pop.exp.het


het %>% group_by(POP) %>%
  summarise(
    count = n(),
    "Individual inbreeding coefficient" = mean(F, na.rm = TRUE),
    SD = sd(F, na.rm = TRUE),
    Median = median(F, na.rm = TRUE),
    IQR = IQR(F, na.rm = TRUE)
  )

pop.F <- het %>%
  ggplot(aes(x=POP, y=F, color = POP)) + 
  geom_boxplot(outlier.shape=8,
               outlier.size=2) +
  geom_jitter(aes(color = POP,  alpha=0.8), size=3) +
  ylim(-0.5,0.2) +
  theme_classic() +
  theme(legend.position = "none") + 
  labs(y= "Individual inbreeding coefficient")+
  scale_color_manual(values=pop.cols)+
  xlab("")

pop.F


library(ggpubr)
png("Het_and_inbreeding.png", width = 800, height =400)
ggarrange(pop.obs.het, pop.F, nrow=1)
dev.off()

```

