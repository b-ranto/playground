use strict;
use warnings;
use integer;

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

my $count = 0;

foreach my $a (1..9){
	foreach my $b (0..9){
		foreach my $c (0..9){
			$count+= $a*100001+$b*10010+$c*1100 if(is_bin_pal(to_bin($a*100001+$b*10010+$c*1100)));
			$count+= $a*10001+$b*1010+$c*100 if(is_bin_pal(to_bin($a*10001+$b*1010+$c*100)));
		}
	}
}

foreach my $a (1..9){
	foreach my $b (0..9){
		$count+= $a*1001+$b*110 if(is_bin_pal(to_bin($a*1001+$b*110)));
		$count+= $a*101+$b*10 if(is_bin_pal(to_bin($a*101+$b*10)));
	}
}

foreach my $a (1..9){
	$count+= $a*11 if(is_bin_pal(to_bin($a*11)));
	$count+= $a if(is_bin_pal(to_bin($a)));
}

print $count, "\n";
