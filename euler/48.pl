use strict;
use warnings;
use integer;

my @primes = prime_gen(100000);
print $primes[$#primes], " ", $#primes, " Gen\n";
exit 0;
#print $_, "\n" foreach @primes;

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

sub permute{
	my @arr = @_;
	my @ret =();
	foreach my $i (0..3){
		foreach my $j (0..3){
			if($i != $j){
				foreach my $k (0..3){
					if($j != $k && $i != $k){
						foreach my $l (0..3){
							@ret = (@ret, $arr[$i]*1000+$arr[$j]*100+$arr[$k]*10+$arr[$l]) if($l != $k && $l != $i && $l != $j);
						}
					}
				}
			}
		}
	}
	return @ret;
}

sub iperm{
	my $a = shift;
	my $b = shift;
	my @an = ($a/1000, ($a/100)%10, ($a/10)%10, $a%10);
	my @bn = ($b/1000, ($b/100)%10, ($b/10)%10, $b%10);
	if(($an[0] ==$bn[0] || $an[0] == $bn[1] ||  $an[0] == $bn[2] || $an[0] == $bn[3]) && ($an[1] ==$bn[0] || $an[1] == $bn[1] ||  $an[1] == $bn[2] || $an[1] == $bn[3]) && ($an[2] ==$bn[0] || $an[2] == $bn[1] || $an[2] == $bn[2] || $an[2] == $bn[3]) && ($an[3] ==$bn[0] || $an[3] == $bn[1] ||  $an[3] == $bn[2] || $an[3] == $bn[3])){
		return 1;
	}
	return 0;
}

foreach my $n (@primes){
	my @ar = permute($n/1000, ($n/100)%10, ($n/10)%10, $n%10);
	foreach my $m (@ar){
		if(prime($m) && $m > $n && prime($m + $m - $n) && iperm($m+$m-$n, $m)){
			print "$n, $m, ", $m+$m-$n, "\n";
		}
	}
}
