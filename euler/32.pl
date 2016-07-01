use strict;
use warnings;

my @tres = ();
my $result = 0;
my $temp = 0;
foreach my $a1 (1..9){
foreach my $a2 (1..9){
if ($a1 != $a2){
foreach my $a3 (1..9){
if ($a1 != $a3 && $a2 != $a3){
foreach my $a4 (1..9){
if($a1 != $a4 && $a2 != $a4 && $a3 != $a4){
foreach my $a5 (1..9){
if($a1 != $a5 && $a2 != $a5 && $a3 != $a5 && $a4 != $a5){
foreach my $a6 (1..9){
if($a1 != $a6 && $a2 != $a6 && $a3 != $a6 && $a4 != $a6 && $a5 != $a6){
foreach my $a7 (1..9){
if($a1 != $a7 && $a2 != $a7 && $a3 != $a7 && $a4 != $a7 && $a5 != $a7 && $a6 != $a7){
foreach my $a8 (1..9){
if($a1 != $a8 && $a2 != $a8 && $a3 != $a8 && $a4 != $a8 && $a5 != $a8 && $a6 != $a8 && $a7 != $a8){
foreach my $a9 (1..9){
if($a1 != $a9 && $a2 != $a9 && $a3 != $a9 && $a4 != $a9 && $a5 != $a9 && $a6 != $a9 && $a7 != $a9 && $a8 != $a9){
	$temp = ($a6*1000+$a7*100+$a8*10+$a9);
	@tres = (@tres, $temp) if(($a1*10+$a2)*($a3*100+$a4*10+$a5) == $temp || $a1*($a2*1000+$a3*100+$a4*10 + $a5) == $temp);
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
print $_, " " foreach @tres;
print "\n";
