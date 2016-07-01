use strict;
use warnings;
use integer;

sub prime{
	(my $a) = @_;
	my $b = int(sqrt($a));
	foreach my $m (2..$b){
		return 0 if($a % $m == 0);
	}
	return 1;
}

sub rotate{
	my $a = shift;
	my $b = $a;
	my $c = -1;
	while($b != 0){
		$b /= 10;
		$c++;
	}
	return $a/10 + ($a % 10)*(10**$c);
}

my $count = 0;
my $r = 0;

foreach my $pb (1..499999){
	if(prime(2*($pb)+1)){
		$r = rotate(2*$pb+1);
		while($r != 2*$pb+1 && prime($r)){
			$r = rotate($r);
		}
		$count++ if($r == 2*$pb+1); #print 2*$pb+1, "\n";
	}
}
print $count + 1, "\n";
