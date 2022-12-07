cd /output/genomic/fish/Macruronus/novaezelandiae/Assembly/Chrs
genome=hoki.chrsAndUnAnchoredSeqs.fa

perl -p -i -e "s/^>group0__1_contigs__length_25972667/>chr01/" $genome
perl -p -i -e "s/^>group1__1_contigs__length_25121579/>chr02/" $genome
perl -p -i -e "s/^>group12__4_contigs__length_23727100/>chr03/" $genome
perl -p -i -e "s/^>group13__3_contigs__length_23415918/>chr04/" $genome
perl -p -i -e "s/^>group22__4_contigs__length_23391960/>chr05/" $genome
perl -p -i -e "s/^>group15__3_contigs__length_22949365/>chr06/" $genome
perl -p -i -e "s/^>group7__2_contigs__length_22523671/>chr07/" $genome
perl -p -i -e "s/^>group2__2_contigs__length_22345241/>chr08/" $genome
perl -p -i -e "s/^>group14__3_contigs__length_22048555/>chr09/" $genome
perl -p -i -e "s/^>group3__4_contigs__length_21784185/>chr10/" $genome
perl -p -i -e "s/^>group8__8_contigs__length_21655309/>chr11/" $genome
perl -p -i -e "s/^>group18__4_contigs__length_21383357/>chr12/" $genome
perl -p -i -e "s/^>group4__3_contigs__length_21336044/>chr13/" $genome
perl -p -i -e "s/^>group11__9_contigs__length_21162437/>chr14/" $genome
perl -p -i -e "s/^>group10__5_contigs__length_20883721/>chr15/" $genome
perl -p -i -e "s/^>group19__2_contigs__length_19752966/>chr16/" $genome
perl -p -i -e "s/^>group6__3_contigs__length_19297640/>chr17/" $genome
perl -p -i -e "s/^>group9__3_contigs__length_19195348/>chr18/" $genome
perl -p -i -e "s/^>group20__4_contigs__length_18971482/>chr19/" $genome
perl -p -i -e "s/^>group5__4_contigs__length_18306511/>chr20/" $genome
perl -p -i -e "s/^>group21__4_contigs__length_17969935/>chr21/" $genome
perl -p -i -e "s/^>group16__2_contigs__length_15985009/>chr22/" $genome
perl -p -i -e "s/^>group17__6_contigs__length_12071207/>chr23/" $genome
perl -p -i -e "s/^>group23__11_contigs__length_11458956/>chr24/" $genome
