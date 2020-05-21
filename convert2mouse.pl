#!usr/bin/perl

use POSIX;
use Data::Dumper;

my $mappingfile=shift@ARGV;
my $datafile=shift@ARGV;


open(INFILE,$mappingfile);
%map=();
<INFILE>;
while (<INFILE>)
{
	chomp;
	@a=split('\t');
	if ($a[1] ne "")
	{
		if (defined $map{'MouseSymbol'}{$a[0]} && $a[1] ne "" )
		{
			$map{'MouseSymbol'}{$a[0]}=$map{'MouseSymbol'}{$a[0]}+1;
			$map{'NewSymbol'}{$a[0]}=$map{'NewSymbol'}{$a[0]}."_".$a[1];
		} 
		else 
		{
			$map{'MouseSymbol'}{$a[0]}=1;
			$map{'NewSymbol'}{$a[0]}=$a[1];
		}
	}

	if (defined $map{'OtherSymbol'}{$a[1]})
	{
		$map{'OtherSymbol'}{$a[1]}=$map{'OtherSymbol'}{$a[1]}+1;
	} 
	else 
	{
		$map{'OtherSymbol'}{$a[1]}=1;
	}
}
close(INFILE);

@order=();
open(INFILE,"order.txt");
while (<INFILE>)
{
	chomp;
	push(@order,$_);
}
close(INFILE);

%data={};
open(INFILE,$datafile);
$line = <INFILE>;
@t=split('\t',$line);
$outline="Symbol mouse\tSymbol";
for ($i=9;$i<=$#t;$i++)
{
	$outline=$outline."\t".$t[$i];
}
print $outline;

while (<INFILE>)
{
	chomp;
	@a=split('\t');
	$data{$a[0]}=$_;
}
close(INFILE);

foreach $key (@order)
{
	$str=$key;

	$new_symbol=$map{'NewSymbol'}{$key};
	$nice_symbol=$new_symbol;
	$str=$str."\t".$nice_symbol;
	@b=split("_",$new_symbol);
	@t=split('\t',$data{$b[0]});
	for ($i=9;$i<=$#t;$i++)
	{
		$val=0;
		foreach $key2 (@b)
		{
			$devide=$map{'OtherSymbol'}{$key2};
			if ($devide < 1) {$devide = 1;}
			$dataline=$data{$key2};
			@c=split('\t',$dataline);
			$val=$val+$c[$i]/$devide;
		}
		$str=$str."\t".$val;
	}
	print $str."\n";
}


