#!/usr/bin/perl
use v5.14;

use warnings;
use strict;


# Neste EP, utilizamos a seguinte lógica:

# (1). Sempre haverá um representante de cada número em todas as colunas.
# (2). Sempre haverá um representante de cada número em todas as linhas.
# (3). Sempre haverá um representante de cada número em todos os quadrados.

# (4). Não deve haver mais de 1 número na mesma coluna.
# (5). Não deve haver mais de 1 número na mesma linha.
# (6). Não deve haver mais de 1 número no mesmo quadrado.

# (7). Nenhuma casinha pode ficar vazia (sem números).


# Como terá um que ter um representante de cada número em uma linha e essa
# linha não pode conter números repetidos, então haverá exatos N números
# distintos nessa linha. E como não podem haver casas vazias, analogamente,
# também não poderá haver casas com mais de 1 número ( logo não precisaremos
# verificar essa condição ).


package main;

open(SAIDA,">", "saida2.txt");

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

my $nClaus;

for(my $i = 0; $i < $N; $i++)
{
  for(my $j = 0; $j < $N; $j++)
  {
    $nClaus++ if($matriz[$i][$j] != 0);    
  }
}

$nClaus += 4*($N**2)+( 3*($N**3)*($N-1)/2 );

  
#-------------------------------------------------------------------------------------------------------------

#Começo do arquivo cnf:
print SAIDA "p cnf $N $nClaus\n";


#-------------------------------------------------------------------------------------------------------------


# Imprime somente a variável que já possui um valor ( sozinha para que ela tenha obrigatóriamente valor 1 ).
for(my $i = 0; $i < $N; $i++)
{
  for(my $j = 0; $j < $N; $j++)
  {
    print SAIDA escreveijk($i,$j,$matriz[$i][$j]-1)." 0\n" if($matriz[$i][$j] != 0);
  }
}

#-------------------------------------------------------------------------------------------------------------

# Para cada k fixado:
#    1- Fixa i: Faz um "ou" entre cada atómo, 1 <= j <= N
# Ou seja, existencia de pelo menos um K verdadeiro em linhas e colunas

# (1). e (2).

for(my $k = 0; $k < $N; $k++)
{
  for(my $i = 0; $i < $N; $i++)
  {
    for(my $j = 0; $j < $N; $j++)
    {
      print SAIDA escreveijk($i,$j,$k)." ";
    }
   print SAIDA "0\n";
    for(my $j = 0; $j < $N; $j++)
    {
      print SAIDA escreveijk($j,$i,$k)." ";
    }
   print SAIDA "0\n";
  }
}

my $raizN = sqrt($N);

#-------------------------------------------------------------------------------------------------------------

# Verifica a existência de pelo menos 1 valor K em cada mini quadrado
# (3).

for(my $o = 0; $o < $N; $o++)                    # Número passado
{
  for(my $k = 0; $k < $raizN; $k++)              # Linha do mini quadrado
  {
    for(my $l = 0; $l < $raizN; $l++)            # Coluna do mini quadrado
    { 
      for(my $m = 0; $m < $raizN; $m++)          # Linha do número de dentro do mini quadrado
      {
          for(my $n = 0; $n < $raizN; $n++)      # Coluna do número de dentro do mini quadrado
          {
            print SAIDA escreveijk($k * $raizN + $m, $l * $raizN + $n, $o). " ";
          }
      }
      print SAIDA "0\n";
    }
  }
}

#-------------------------------------------------------------------------------------------------------------

# Fixado i,j,k, Se Pijk é verdadeiro, isso implica
# que Prjk é falso, 0 < r < N, r != i
# Pirk é falso, 0 < r < N, r != j
# O quadrado de onde esta Pij é falso.

# (4). e (5).

for(my $k = 0; $k < $N; $k++)                     
{
  for(my $i = 0; $i < $N; $i++)                        
  {
    for(my $j = 0; $j < $N; $j++)
    {
      for(my $i2 = $i+1; $i2 < $N; $i2++)
      {
          print SAIDA -escreveijk($i,$j,$k)." ".-escreveijk($i2,$j,$k)." 0\n"; #unless($i == $i2);         
      }
      for(my $j2 = $i+1; $j2 < $N; $j2++)
      {
        print SAIDA -escreveijk($j,$i,$k)." ".-escreveijk($j,$j2,$k)." 0\n"; #unless($i == $i2);
      }
    }
  }
}

#-------------------------------------------------------------------------------------------------------------

# Não deve haver mais de um número no mesmo mini quadrado

# Fixamos um $o( número passado ), um $k( linha do mini quadrado ), um $l( coluna do mini quadrado ),
# um $m( linha do número dentro do mini quadrado ), um $n( coluna do número do mini quadrado ),
# um $m2( linha de outro número do mini quadrado ), e um $n2( coluna de outro número do mini quadrado ).

# (6).

for(my $o = 0; $o < $N; $o++)                           # Número passado
{
  for(my $k = 0; $k < $raizN; $k++)                     # Linha do mini quadrado
  {
    for(my $l = 0; $l < $raizN; $l++)                   # Coluna do mini quadrado
    { 
      for(my $m = 0; $m < $raizN; $m++)                 # Linha do número de dentro do mini quadrado
      {
        for(my $n = 0; $n < $raizN; $n++)               # Coluna do número de do mini quadrado
        {
          for(my $m2 = 0; $m2 < $raizN; $m2++)          # Linha de outro número do mini quadrado
          {
            for(my $n2 = 0; $n2 < $raizN; $n2++)        # Coluna de outro número do mini quadrado
            {
              # Não permite que sejam comparados 2 quadrados iguais ou que sejam comparados dois quadrados que já foram comparados antes.
              if(escreveijk($k * $raizN + $m, $l * $raizN + $n, $o) > escreveijk($k * $raizN + $m2, $l * $raizN + $n2, $o))
              {
                print SAIDA -escreveijk($k * $raizN + $m, $l * $raizN + $n, $o). " " . -escreveijk($k * $raizN + $m2, $l * $raizN + $n2, $o). " 0\n"; 
              }
            }
          } 
        }
      }
    }
  }
}

#-------------------------------------------------------------------------------------------------------------


# Imprime em uma linha, todas as variáveis que estejam na mesma casinha. Para que as casas tenham pelo menos 1 número.

# (7).

for(my $i = 0; $i < $N; $i++)
{
  for(my $j = 0; $j < $N; $j++)
  {
    for(my $k = 0; $k < $N; $k++)
    {
      print SAIDA escreveijk($i, $j, $k)." ";
    }
    print SAIDA "0\n";
  }
}


#-------------------------------------------------------------------------------------------------------------

# Transforma as coordenadas e o número de cada variável num outro número ( sendo este único para cada variável ).
sub escreveijk
{
  my ($i, $j, $k) = (@_);
  return ($N**2)*$i + $N*$j + $k + 1;
}





#-------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------

# TRATANDO A SAÍDA DO PROGRAMA:

$, = " | ";

# Chamando o minisat com a saida gerada por este programa.
qx|minisat saida2.txt a.out|;

# Chamando o programa que imprime a matriz resposta.
my $resposta = qx|./tradutor.pl a.out|;

# Imprimindo a matriz dada como saída na chamada do programa "tradutor.pl".
print $resposta;

