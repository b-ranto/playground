use strict;
use warnings;

sub build{
	(my @arr) = @_;
	my $torem = pop(@arr);
	my @ret =  ();
#	print @arr, "\n";
#	print $#arr, " ", $torem, "\n";
	foreach my $p (0..$#arr){
		@ret = (@ret, $arr[$p]) if($arr[$p] != $torem);
	}
	return @ret;
}

sub permute{
	my @res = @_;
	my @bas = (1..9);
	foreach my $pr (@res){
		@bas = build(@bas, $pr);
	}
	if(@bas > 1){
		foreach my $s (0..$#bas){
			push(@res, $bas[$s]);
			permute(@res);
			pop(@res);
		}
	}
	else{
#		print $_ foreach @res;
#		print $bas[0], "\n";
	}
}

#foreach (1..9){
#	print build((1..9), $_), "\n";
#}

permute(());
