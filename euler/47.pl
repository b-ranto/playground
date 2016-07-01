use strict;
use warnings;

our(@primes);
@primes = prime_gen(30000);
print "Gen\n";

sub prime{
	(my $a) = @_;
	my $b = int(sqrt($a));
	foreach my $m (2..$b){
		return 0 if($a % $m == 0);
	}
	return 1;
}

sub prime_gen{
	my $max = shift;
	my @ret = ();
	foreach my $a (2..$max){
		@ret = (@ret, $a) if(prime($a));
	}
	return @ret;
}

sub is4div{
	my $w = shift;
	my $done = 0;
	for(my $n = 0;$n < @primes && $w > 1;$n++){
		if($w % $primes[$n] == 0){
			$done++;
			while($w % $primes[$n] == 0){
				$w = $w / $primes[$n];
			}
		}
	}
	return 1 if $done == 4;
	return 0;
}
print is4div(210),"\n";
my $done = 0;
my $i = 5, my $w = 0;
while(!$done){
	$i++;
	$done = 0;
	$w = $i;
	$done = 1;
	for(my $n = 0;$n < 4;$n++){
		if(!is4div($i+$n)){
			$i = $i + $n;
			$n = 7;
			$done = 0;
		}
	}
#	print $i, "\n";
}
print $i, "\n";
