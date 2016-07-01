use strict;
use warnings;
use integer;
sub gen_next{
	my @inp = @_;
	my $res = $inp[$#inp];
	my $prime = 0;
	while(!$prime){
		$res++;
		my $max = int(sqrt($res));
		$prime = 1;
		for(my $i = 0;$inp[$i] <= $max && $prime == 1 ;$i++){
			$prime = 0 if($res % $inp[$i] == 0);
		}
	}
	return $res;
}

#sub prime{
#	my $n = shift;
#	my $max = int(sqrt($n));
#	foreach my $i (2..$max){
#		return 0 if($n % $max == 0);
#	}
#	return 1;
#}

my @primes = (2);
while ($primes[$#primes] < 99991){
	$primes[++$#primes] = gen_next(@primes);
	#print $primes[$#primes], "\n";
}
print $primes[$#primes], " ", $#primes, "\n";
#my $sum = 0;
#$sum += $_ foreach @primes;
#print $sum;
