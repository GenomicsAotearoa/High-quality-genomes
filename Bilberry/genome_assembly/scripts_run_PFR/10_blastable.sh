logDir=/workspace/hrachd/Bilberry/2020/16_SoftMask/.log

module load ncbi-blast/2.6.0

bsub -m wkoppb50 -o $logDir/blastDB.NCBI.Genes.log -e $logDir/blastDB.NCBI.Genes.err -J VmyGene "makeblastdb -dbtype nucl -in Bilberry.NCBI.gene.fna -input_type fasta -parse_seqids -title Bilberry.NCBI.Genes -logfile $logDir/Bilberry.NCBI.Genes"

bsub -m wkoppb50 -o $logDir/blastDB.NCBI.prot.log -e $logDir/blastDB.NCBI.prot.err -J VmyProt "makeblastdb -dbtype prot -in Bilberry.NCBI.prot.faa -input_type fasta -parse_seqids -title Bilberry.NCBI.Proteins -logfile $logDir/Bilberry.NCBI.prot"

