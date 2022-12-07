thread=20
dataDir=/workspace/hrachd/Bilberry/03_trimmomatic
StarIDX=/workspace/hrachd/Bilberry/2020/16_SoftMask/01_Index
samDir=/workspace/hrachd/Bilberry/2020/16_SoftMask/05_Star
logDir=$samDir/.log
mkdir -p $logDir

module load STAR/2.6.1d

bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS30Sk1901.log -o $logDir/VmS30Sk1901.err -n $thread -J VmS30Sk1901 " cd $dataDir; STAR --outSAMattrRGline ID:VmS30Sk1901 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 1_R1.fq.gz 1_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS30Sk1901 --outSAMtype BAM SortedByCoordinate"


bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS35Sk1904.log -o $logDir/VmS35Sk1904.err -n $thread -J VmS35Sk1904 " cd $dataDir; STAR --outSAMattrRGline ID:VmS35Sk1904 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 4_R1.fq.gz 4_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS35Sk1904 --outSAMtype BAM SortedByCoordinate"


bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS40Sk1907.log -o $logDir/VmS40Sk1907.err -n $thread -J VmS40Sk1907 " cd $dataDir; STAR --outSAMattrRGline ID:VmS40Sk1907 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 7_R1.fq.gz 7_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS40Sk1907 --outSAMtype BAM SortedByCoordinate"


bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS45Sk1910.log -o $logDir/VmS45Sk1910.err -n $thread -J VmS45Sk1910 " cd $dataDir; STAR --outSAMattrRGline ID:VmS45Sk1910 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 10_R1.fq.gz 10_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS45Sk1910 --outSAMtype BAM SortedByCoordinate"


bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS50Sk1913.log -o $logDir/VmS50Sk1913.err -n $thread -J VmS50Sk1913 " cd $dataDir; STAR --outSAMattrRGline ID:VmS50Sk1913 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 13_R1.fq.gz 13_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS50Sk1913 --outSAMtype BAM SortedByCoordinate"



bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS30Pu1916.log -o $logDir/VmS30Pu1916.err -n $thread -J VmS30Pu1916 " cd $dataDir; STAR --outSAMattrRGline ID:VmS30Pu1916 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 16_R1.fq.gz 16_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS30Pu1916 --outSAMtype BAM SortedByCoordinate"



bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS35Pu1919.log -o $logDir/VmS35Pu1919.err -n $thread -J VmS35Pu1919 " cd $dataDir; STAR --outSAMattrRGline ID:VmS35Pu1919 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 19_R1.fq.gz 19_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS35Pu1919 --outSAMtype BAM SortedByCoordinate"



bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS40Pu1922.log -o $logDir/VmS40Pu1922.err -n $thread -J VmS40Pu1922 " cd $dataDir; STAR --outSAMattrRGline ID:VmS40Pu1922 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 22_R1.fq.gz 22_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS40Pu1922 --outSAMtype BAM SortedByCoordinate"



bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS45Pu1925.log -o $logDir/VmS45Pu1925.err -n $thread -J VmS45Pu1925 " cd $dataDir; STAR --outSAMattrRGline ID:VmS45Pu1925 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 25_R1.fq.gz 25_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS45Pu1925 --outSAMtype BAM SortedByCoordinate"



bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS50Pu1928.log -o $logDir/VmS50Pu1928.err -n $thread -J VmS50Pu1928 " cd $dataDir; STAR --outSAMattrRGline ID:VmS50Pu1928 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 28_R1.fq.gz 28_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS50Pu1928 --outSAMtype BAM SortedByCoordinate"


bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS30WF1932.log -o $logDir/VmS30WF1932.err -n $thread -J VmS30WF1932 " cd $dataDir; STAR --outSAMattrRGline ID:VmS30WF1932 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 32_R1.fq.gz 32_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS30WF1932 --outSAMtype BAM SortedByCoordinate"


bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS35WF1934.log -o $logDir/VmS35WF1934.err -n $thread -J VmS35WF1934 " cd $dataDir; STAR --outSAMattrRGline ID:VmS35WF1934 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 34_R1.fq.gz 34_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS35WF1934 --outSAMtype BAM SortedByCoordinate"



bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS40WF1937.log -o $logDir/VmS40WF1937.err -n $thread -J VmS40WF1937 " cd $dataDir; STAR --outSAMattrRGline ID:VmS40WF1937 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 37_R1.fq.gz 37_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS40WF1937 --outSAMtype BAM SortedByCoordinate"



bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS45WF1940.log -o $logDir/VmS45WF1940.err -n $thread -J VmS45WF1940 " cd $dataDir; STAR --outSAMattrRGline ID:VmS45WF1940 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 40_R1.fq.gz 40_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS45WF1940 --outSAMtype BAM SortedByCoordinate"



bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmS50WF1943.log -o $logDir/VmS50WF1943.err -n $thread -J VmS50WF1943 " cd $dataDir; STAR --outSAMattrRGline ID:VmS50WF1943 --runThreadN $thread --genomeDir $StarIDX --readFilesIn 43_R1.fq.gz 43_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmS50WF1943 --outSAMtype BAM SortedByCoordinate"



bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmRoots.log -o $logDir/VmRoots.err -n $thread -J VmRoots " cd $dataDir; STAR --outSAMattrRGline ID:VmRoots --runThreadN $thread --genomeDir $StarIDX --readFilesIn 46_R1.fq.gz 46_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmRoots --outSAMtype BAM SortedByCoordinate"

bsub -m "wkoppb50 aklppb39 wkoppg31" -o $logDir/VmLeaves.log -o $logDir/VmLeaves.err -n $thread -J VmLeaves " cd $dataDir; STAR --outSAMattrRGline ID:VmLeaves --runThreadN $thread --genomeDir $StarIDX --readFilesIn 47_R1.fq.gz 47_R2.fq.gz --readFilesCommand zcat --outFileNamePrefix $samDir/VmLeaves --outSAMtype BAM SortedByCoordinate"




