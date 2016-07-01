use strict;
use warnings;

sub is_pent{
	(my $D, my $dperm) = @_;
	my $n = $dperm + 1;
	my $i = $D + 1 + 3*$dperm;
	my $int = 0;
	while(3*$n - 2 <= $D){
		$int = (1 + sqrt(1+24*($i-$D)))/6;
		if(int($int) == $int){
			$int = (1 + sqrt(1+24*(2*$i-$D)))/6;
			if(int($int) == $int){
				print "We found it: $D\n";
				return 1;
			}
		}
		$i += 1 + 3*$n;
		$n++;
	}
	return 0;
}

my $diff = 1;
my $poc = 1;

while(!is_pent($diff, $poc)){
	$diff += 1 + 3*$poc;
	$poc++;
}

exit 0;
