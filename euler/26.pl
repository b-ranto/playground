use strict;
use warnings;

my $a = 1;
my @arr = ();
my $rslt = 0;
my $rcnt = 0;
my $count = 0;
foreach my $x (11..1000){
	$a = 1;
	$count = 0;
	@arr = ();
	while($a != 0 && $count == 0){
		$a = ($a % $x)*10;
		foreach my $f (0..$#arr){
			$count = $#arr - $f if($arr[$f] == $a && $count == 0);
		}
		@arr = (@arr, $a);
	}
#	print $count, " ", $x, "\n";

	if($count > $rcnt){
		$rslt = $x;
		$rcnt = $count;
	}
}
print $rcnt, " ", $rslt, "\n";
		
