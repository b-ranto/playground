use strict;
use warnings;
use integer;

sub gcd{
	(my $v1, my $v2) = @_;
#	print $v1 % $v2, " ", $v2, "\n";
	if($v1 % $v2 != 0){
		return gcd($v2,$v1 % $v2);
	}
	else{
		return $v2;
	}
}

#print gcd(27, 45), "\n";
#exit 0;

my $g1 = 0;
my $g2 = 0;

foreach my $a (1..9){
	foreach my $b (1..9){
		$g1 = gcd($a,$b);
		foreach my $c (1..9){
			if($a*10+$c < $b*10+$c){
				$g2 = gcd($a*10+$c,$b*10+$c);
				if(($a*10+$c)/$g2 == $a/$g1 && ($b*10+$c)/$g2 == $b/$g1){
					print $a*10+$c, "/", $b*10+$c, " - ", $g2, "\n";
				}
			}
			if($a*10+$c < $c*10+$b){
				$g2 = gcd($a*10+$c,$c*10+$b);
				if(($a*10+$c)/$g2 == $a/$g1 && ($c*10+$b)/$g2 == $b/$g1){
					print $a*10+$c, "/", $c*10+$b, " - ", $g2, "\n";
				}
			}
			if($c*10+$a < $c*10+$b){
				$g2 = gcd($c*10+$a,$c*10+$b);
				if(($c*10+$a)/$g2 == $a/$g1 && ($c*10+$b)/$g2 == $b/$g1){
					print $c*10+$a, "/", $c*10+$b, " - ", $g2, "\n";
				}
			}
			if($c*10+$a < $b*10+$c){
				$g2 = gcd($c*10+$a,$b*10+$c);
				if(($c*10+$a)/$g2 == $a/$g1 && ($b*10+$c)/$g2 == $b/$g1){
					print $c*10+$a, "/", $b*10+$c, " - ", $g2, "\n";
				}
			}
		}
	}
}

