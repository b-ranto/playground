use strict;
use warnings;
my $result = 0;
my $sum = 0;
foreach my $a (0..9){
	foreach my $b (0..9){
		foreach my $c (0..9){
			foreach my $d (0..9){
				foreach my $e (0..9){
					foreach my $f (0..9){
						$sum = $a*(100000 - $a**4) + $b*(10000 - $b**4) + $c*(1000 - $c**4) + $d*(100 - $d**4) + $e*(10 - $e**4) + $f*(1 - $f**4);
						$result += $a*100000 + $b*10000 + $c*1000 + $d*100 + $e*10 + $f if $sum == 0;
					}
				}
			}
		}
	}
}
print $result, "\n";
