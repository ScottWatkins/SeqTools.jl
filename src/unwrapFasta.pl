#!/usr/bin/perl -w
# This script reads a wrapped fasta file and
# outputs an unwrapped fasta file. Input may be a file.

use strict;

use Getopt::Long;
$| =1;
my $help = ();
GetOptions( "help"  => \$help);

if ($help) {
  print "\n\nThis script reads a wrapped fasta
file and ouputs an unwrapped file.

USAGE: unwrapFastq.pl <wrapped_fastq>\n\n";
  exit;
}

open (IN, "<$ARGV[0]");
my @all = <IN>;
chomp @all;

for (my $i=0; $i <= $#all; $i++) {
  if (defined $all[$i+1]) {
    if ($all[$i] =~ />/) {
      print "$all[$i]\n";
    } elsif ( $all[$i+1] =~ />/) {
      print "$all[$i]\n";
    } else { 
      print "$all[$i]";
    }
  } else {
    print "$all[$i]\n";
  }
}
