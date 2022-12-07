cmdDir=`pwd`
workDir=/output/genomic/fish/Macruronus/novaezelandiae/Assembly/Chrs

## backup the original results
cd $workDir
#tar -czvf Hoki.originalIDs.tgz hoki.*

## Create cmds to rename chr IDs based on length
inFile=Chrs.old_vs_new_IDs.txt

for file in hoki.Chrs.fa hoki.chrsAndUnAnchoredSeqs.fa
do
   cmdFile=${file/fa/sh}
   echo "cd $workDir" > $cmdDir/$cmdFile
   echo "genome=$file" >> $cmdDir/$cmdFile
   echo >> $cmdDir/$cmdFile
   perl -lane 'if (m/^group/) {my ($oldID, $newID) = ($F[0], $F[2]); print "perl -p -i -e \"s/^>$oldID/>$newID/\" \$genome";}' $inFile >> $cmdDir/$cmdFile
done

