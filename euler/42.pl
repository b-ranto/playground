use strict;
use warnings;

open(my $f, "< ../mess/words.txt");

my @arr = ();
push(@arr,0) foreach 1..193;

$arr[($_*($_+1))/2] = 1 foreach 1..19;

my $w = 0;
my $print = 0;
while((my $c = getc($f))){
	if(ord($c) == ord('"')){
		if($w){
			$w = 0;
			print $print,"\n" if $arr[$print];
			$print = 0;
		}
		else{
			$w = 1;
		}
	}
	$print += ord($c)-64 if($w && ord($c) != ord('"'));
	
}
