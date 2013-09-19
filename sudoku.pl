#!/usr/bin/perl
use v5.14;

use warnings;
use strict;


package main;

my @vetor;

  while(<>)
  {
    @vetor = (@vetor,split);
    
    

  }

our $N = sqrt(@vetor);
my @matriz;

for(my $i = 0; $i < $N; $i++)
{
  my @vetorTemp = (@vetor[(0 + $i*$N)..($N-1 + $i*$N)]);
  $matriz[$i] = \@vetorTemp;
}


my $nClaus = 0; #Temporário.


for(my $i = 0; $i < $N; $i++)
{
  for(my $j = 0; $j < $N; $j++)
  {
    print escreveijk($i,$j,$matriz[$i][$j]-1)." 0\n" if($matriz[$i][$j] != 0);
    $nClaus++;
  }
}
  




#Começo do arquivo cnf:
#print "p cnf $N $nClaus";

#Para cada k fixado:
#    1- Fixa i: Faz um ou entre cada atómo, 1 <= j <= N
#    1- Fixa j: Faz um ou entre cada atómo, 1 <= i <= N
#Ou seja, existencia de pelo menos um K verdadeira, fixado linha ou coluna

##2*n²
for(my $k = 0; $k < $N; $k++)
{
  for(my $i = 0; $i < $N; $i++)
  {
    for(my $j = 0; $j < $N; $j++)
    {
      print escreveijk($i,$j,$k)." ";
    }
   print "0\n";
    for(my $j = 0; $j < $N; $j++)
    {
      print escreveijk($j,$i,$k)." ";
    }
   print "0\n";
  }
}

my $raizN = sqrt($N);

# Verifica a existenci9a nos quadrados médios

#N²

for(my $o = 0; $o < $N; $o++)
{ # o = número passado
  for(my $k = 0; $k < $raizN; $k++)
  { # k = controle de linha - grid
    for(my $l = 0; $l < $raizN; $l++)
    { 
      for(my $m = 0; $m < $raizN; $m++)
      {
          for(my $n = 0; $n < $raizN; $n++)
          {
            print escreveijk($k * $raizN + $m, $l * $raizN + $n, $o). " ";
          }
      }
      print "0\n";
    }
  }
}

#Fixado i,j,k, Se Pijk é verdadeiro, isso implica
# que Prjk é falso, 0 < r < N, r != i
#  Pirk é falso, 0 < r < N, r != j
#  O quadrado de onde esta Pij é falso.

#a -> b == -a v b
 #print "="x100;
 #print "\n";
for(my $k = 0; $k < $N; $k++)
{
  for(my $i = 0; $i < $N; $i++)
  {
    for(my $j = 0; $j < $N; $j++)
    {
      for(my $i2 = $i+1; $i2 < $N; $i2++)
      {

          print -escreveijk($i,$j,$k)." ".-escreveijk($i2,$j,$k)." 0\n"; #unless($i == $i2);
          

      }

      for(my $j2 = $i+1; $j2 < $N; $j2++)
      {
        print -escreveijk($j,$i,$k)." ".-escreveijk($j,$j2,$k)." 0\n"; #unless($i == $i2);
      }

    }
  }
}




for(my $o = 0; $o < $N; $o++)
{ # o = número passado

  for(my $k = 0; $k < $raizN; $k++)
  { # k = controle de linha - grid
    for(my $l = 0; $l < $raizN; $l++)
    { 
      for(my $m = 0; $m < $raizN; $m++)
      {
          for(my $n = 0; $n < $raizN; $n++)
          {
            for(my $m2 = 0; $m2 < $raizN; $m2++)
            {
                for(my $n2 = 0; $n2 < $raizN; $n2++)
                {
                 print -escreveijk($k * $raizN + $m, $l * $raizN + $n, $o). " " . -escreveijk($k * $raizN + $m2, $l * $raizN + $n2, $o). " 0\n" if(escreveijk($k * $raizN + $m, $l * $raizN + $n, $o) > escreveijk($k * $raizN + $m2, $l * $raizN + $n2, $o));
                }
            } 
          }
      }
    }
  }
}




#for(my $i = 0; $i < $N; $i++)
#{
#  for(my $j = 0; $j < $N; $j++)
#  {
#    for(my $k = 0; $k < $N; $k++)
#    {
   #   print escreveijk($i,$j,$k)." ";
  #  }
 # }
#}



$, = " | ";

for(my $i = 0; $i < $N; $i++)
{
#  print (@{$matriz[$i]});
#  print "\n";
#  print "-"x30;
#  print "\n";
}



sub escreveijk
{
  my ($i, $j, $k) = (@_);
#return ($N**2)*$i + $N*$j + $k + 1;
return 100*$i + 10*$j + $k + 1;
}
