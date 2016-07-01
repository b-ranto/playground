use strict;
use warnings;
my @result = ();
print $#result, "\n";
my $temp = 0;
my $write = 0;
foreach my $a (2..100){
	foreach my $b (2..100){
		$temp = $a**$b;
		$write = 1;
		foreach my $c (@result){
			$write = 0 if $temp == $c;
		}
		@result = (@result, $temp) if $write == 1;
	}
}
print $#result, "\n";
