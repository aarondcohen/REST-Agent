use REST::Agent;

my $agent = REST::Agent->new(foo => 1, bar => 2);

use Data::Dumper;
local $\="\n";
print Dumper $agent;
