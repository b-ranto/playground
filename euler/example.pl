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

sub rotate{#Rotates the number
	my $a = shift;
	my $b = $a;
	my $c = -1;
	while($b != 0){
		$b /= 10;
		$c++;
	}
	return $a/10 + ($a % 10)*(10**$c);
}

sub to_bin{
	(my $n) = @_;
	my @result = ();
	while($n > 0){
		@result = ($n%2,@result);
		$n /= 2;
	}
	return @result;
}

sub is_bin_pal{
	(my @bin) = @_;
	foreach my $c (0..($#bin/2)){
		return 0 unless($bin[$c] == $bin[$#bin - $c]);
	}
	return 1;
}
