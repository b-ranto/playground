my $count = 0;
#sub build{
#	my ($tbb) = @_;
#	foreach my $val (1,2,5,10,20,50,100){
#		build($tbb + $val) if($tbb + $val < 200);
#		$count++ if ($tbb + $val == 200);
#	}
#	return $count;
#}

print 0..-1, "\n";
foreach my $val (0..-1){
	print $val, "d'oh\n";
}
foreach my $a (0..200){
	foreach my $b (0..(100 - $a/2)){
		foreach my $c(0..((200 -$a - 2*$b)/5)){
			foreach my $d (0..((200 - $a - 2*$b - 5*$c)/10)){
				foreach $e (0..(200 - $a - 2*$b - 5*$c - 10*$d)/20){
					foreach $f (0..((200 - $a - 2*$b - 5*$c - 10*$d - 20*$e)/50)){
						foreach $g (0..((200 - $a - 2*$b - 5*$c - 10*$d - 20*$e - 50*$f)/100)){
							$count++ if($a+2*$b+5*$c+10*$d+20*$e+50*$f+100*$g == 200);
						}
					}
				}
			}
		}
	}
}
print $count, "\n";
