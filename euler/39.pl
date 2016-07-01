use strict;
use warnings;

my $m = 8/5;
print $m, "\n" if($m == int($m)) ;

my $a = 0;
my $count = 0;
foreach my $p (1..1000){
	$count = 0;
	foreach my $b (1..int($p/2)){
		$a = ($p*$p-2*$p*$b)/(2*($p-$b));
		$count ++ if($a > 0 && $a < $b && $a == int($a) && sqrt($a*$a+$b*$b) == int(sqrt($a*$a+$b*$b)));
	}
	print $p, " ", $count, "\n";
}
		
