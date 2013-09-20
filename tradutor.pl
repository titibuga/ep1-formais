#!/usr/bin/perl
use v5.14;

use warnings;
use strict;

use POSIX;


package main;


my @vetor;
while(<>)
{
  $_ =~ s/SAT//;
  @vetor = (@vetor,split);
}


my @matriz;



foreach (@vetor)
{
  if($_ > 0)
  {
    my ($i, $j, $k) = traduz($_);
    $matriz[$i][$j] = $k;
  }
}

$, = " | ";
my $cont = 0;
print "\n";

foreach (@matriz)
{
  my @vetorTemp = @$_;
  if($cont%3 == 0)
  {
    print  ("="x41);
    print "\n";
  }
  $cont++;
  print "|| ";
  print @vetorTemp[0..2];
  print " || ";
  print @vetorTemp[3..5];
  print " || ";
  print @vetorTemp[6..8];
  print " || ";
    
  print "\n";
}
  print  ("="x41 ."\n\n\n");

sub traduz
{
  $_[0]--;
  my ($i, $j, $k);
  my $i1 = $_[0]%81;
  $i = floor($_[0]/81); 
  my $j2 = $i1 % 9;
  $j = floor($i1/9);
  $k = $j2;
  return ($i, $j, $k+1);
}
