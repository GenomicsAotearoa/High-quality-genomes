#!/usr/bin/perl
use strict;
# 
# Tool developed by Cecilia D.
# Convert HiCSuite group xlsx file to required ordering file format
# Tab delimited with columns:
# SeqID	RC	Q	GapSize
# Where: SeqID is the contig ID in the de novo assembly
# 	RC is 0 (not reverse complement) or 1 (reverse complement)
# 	Q: quality. NOT used. I record Seq length here
# 	GapSize:	gap size in joining contigs. I use '.' here

my $workDir='/workspace/hrachd/Fish/2021/HiC/11_200M_data/HiCSuite/HiCSuiteGroups';
my $inFile='hoki_chr.txt';

chdir($workDir);
my %h=();

##Chr    Scaffold        Size (MB)
#1       +scaffold_251_pilon_pilon       25.972
#
#2       +scaffold_647_pilon_pilon       25.115
#
#3       -scaffold_7_pilon_pilon 0.683
#3       +scaffold_609_pilon_pilon       21.653
#
open(IN, "<$inFile") or die "Can't open $inFile\n\n";
while (my $line = <IN>) {
    next unless $line;
    next unless ($line =~ m/^\d+/);
    chomp $line;
    $line =~ s/\r//g;
    my ($grp, $str, $q) = split /\t/, $line; 
    
    my $n = $grp - 1;
    my $name='group' . $n . '.ordering';
    if ($str =~ m/^(.)(\S+)/) {
       my ($strand, $id) = ($1, $2);
       my $rc = ($strand eq "-") ? 1 : 0;
       $h{$name} .= join("\t", $id, $rc, $q, '.') . "\n";    
    }
}
close IN;

foreach my $grp (keys %h) {
    open(OUT, ">$grp") or die "Can't open $grp to write\n\n";
    print OUT $h{$grp};
    close OUT;
    print "Saved $grp ...\n";
}
print "Done!\n\n";

exit();
