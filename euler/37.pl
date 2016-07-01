use strict;
use warnings;
use integer;

sub prime{
	(my $a) = @_;
	return 0 if($a == 1);
	my $b = int(sqrt($a));
	foreach my $m (2..$b){
		return 0 if($a % $m == 0);
	}
	return 1;
}

foreach my $b1 (0..9){
	foreach my $b2 (0..9){
		foreach my $b3 (0..9){
			foreach my $a (2,3,5,7){
				foreach my $c (3,7){
					print $a,$b1,$b2,$b3,$c,"\n" if(prime($a*10000+$b1*1000+$b2*100+$b3*10+$c) && prime($a*1000+$b1*100+$b2*10+$b3) && prime($a*100+$b1*10+$b2) && prime($a*10+$b1) && prime ($b1*1000+$b2*100+$b3*10+$c) && prime($b2*100+$b3*10+$c) && prime($b3*10+$c));
				}
			}
		}
	}
}

foreach my $i (10..999999){
	print $i, "\n" if(prime($i) && prime($i/10) && prime($i/100) && prime($i/1000) && prime($i/10000) && prime($i/100000) && prime($i % 10) && prime($i % 100) && prime($i %1000) && prime($i % 10000) && prime($i % 100000));
}
