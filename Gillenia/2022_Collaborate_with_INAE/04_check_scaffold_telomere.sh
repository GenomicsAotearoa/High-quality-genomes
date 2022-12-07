baseDir=/workspace/hrachd/Gillenia/2022/INRAE
logDir=$baseDir/.log
file=ragtag.scaffolds.fasta

for hap in hap1 hap2
do
  cd $baseDir/$hap
  outFile='Gillenia1CCS.scaf.'$hap'_100k'
  bsub -o $logDir/$hap'.scaf.tidk.log' -e $logDir/$hap'.scaf.tidk.err' -J $hap -m wkoppb30 "/workspace/hraijc/git_clones/telomeric-identifier/target/release/tidk search -s TTAGGG --fasta $file --output $outFile --window 100000"
done

for hap in hap1 hap2
do
  cd $baseDir/$hap/search
  file='Gillenia1CCS.scaf.'$hap'_100k_telomeric_repeat_windows.csv'
  /workspace/hraijc/git_clones/telomeric-identifier/target/release/tidk plot -h 120 -w 800 -c $file -o 'Gillenia1CCS.Scaf.'$hap'.telomerics'
done
