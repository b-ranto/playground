use warnings;
use strict;
my @animals = ("camel", "octopus", "lobster");
print 1..10, "\n";
my @poa = @animals[0,1];
print @animals, " ", @animals[0..1], "\n";

print @animals[-2..2], "\n";

my @variable = (@animals, @poa);
print "\nPrinting variable\n";
print $_, " " foreach @variable;
print "\n";
print $_, " " foreach my @fruit = ("alice", "bob", 42, 37, "mammal");
print "\n", 3**2.1, "\n";
print $_, " " foreach @animals;
print "\n";
