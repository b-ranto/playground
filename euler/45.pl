use strict;
use warnings;

my $h = 144;
my $val = 40755 + 1 + 4*143;
my $inta,my $intb;
while(1){
	$inta = (1 + sqrt(1+24*$val))/6;
	$intb = (-1+ sqrt(1+ 8*$val))/2;
	if(int($inta) == $inta && int($intb) == $intb){
		print "Tada: $val\n";
		break;
	}
	$val += 1 + 4*$h;
	$h++;
}
