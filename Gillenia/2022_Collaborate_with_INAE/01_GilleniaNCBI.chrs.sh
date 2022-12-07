inFile=/output/genomic/plant/Gillenia/trifoliata/Assembly/gillenia_genome_v1.NCBI.fasta
faiFile=/output/genomic/plant/Gillenia/trifoliata/Assembly/gillenia_genome_v1.NCBI.fasta.fai

perl -lane 'if (m/^Chr/) {print $F[0];}' $faiFile > tmp.GilleniaNCBI.chr.IDs
perl /workspace/hrachd/tools/extract_fasta_seqs_with_list.pl -f=$inFile -l=tmp.GilleniaNCBI.chr.IDs -o=GilleniaNCBI.chrs.fa

