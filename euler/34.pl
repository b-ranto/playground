use strict;
use warnings;
use integer;

sub fact{
	(my $a) = @_;
	if($a == 0){
		return 1;
	}
	else{
		return $a*fact($a-1);
	}
}

my @facts = 0..9;

foreach my $val (0..9){
	$facts[$val] = fact($val);
}

my $vl = 1345678;
#print $vl % 10,$vl/10 % 10,$vl/100 % 10,$vl/1000 % 10,$vl/10000 % 10,$vl/100000 %10,$vl/1000000 % 10, "\n";

foreach my $val (10..99){
	if($facts[$val % 10] + $facts[$val/10 % 10] == $val){
		print $val, "\n";
	}
}

#print $_, " " foreach @facts;
print "\nDone\n";
