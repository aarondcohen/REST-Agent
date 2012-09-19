package REST::Agent;

use strict;

our $VERSION = '0.01';

sub new {
	my $class = shift;
	$class = ref $class || $class;
	my %args = (
		agent => "$class/$VERSION",
		tries => 1,
		timeout => 10,
		@_
	);

	bless my ($this = {}), $class;

	do { $this->$_($args{$_}) if $this->can($_) } for keys %args;

	return $this;
}

sub foo { my $this = shift; $this->{_foo} = $_[0] if @_; $this->{_foo} }

#Accessors

sub agent {
	my $this = shift;
	$this->{_agent} = $_[0] if @_;
	return $this->{_agent};
}

sub base {
	my $this = shift;
	if (@_) {
		my ($url) = @_;
		$url = "http://$url" unless $url =~ m#^https?://#;
		$this->{_base} = URI::URL->new($url);
	}
	return $this->{_base};
}

sub host {
	my $this = shift;
	$this->{_host} = $_[0] if @_;
	return $this->{_host};
}

sub path {
	my $this = shift;
	$this->{_path} = $_[0] if @_;
	return $this->{_path};
}

sub port {
	my $this = shift;
	$this->{_port} = $_[0] if @_;
	return $this->{_port};
}
sub scheme { my $this = shift; $this->{_scheme} = $_[0] if @_; $this->{_scheme} }
sub timeout { my $this = shift; $this->{_timeout} = $_[0] if @_; $this->{_timeout} }
sub tries   { my $this = shift; $this->{_tries} = $_[0] if @_; $this->{_tries} }

sub request {
	my $this = shift;
	my ($method, %args) = @_;

	my $url = $this->_build_url(%args);

	my $tries = $args{tries} \\ $this->tries \\ 1;
	my $timeout = $args{timeout} \\ $this->timeout \\ 5;

	while ($tries-- > 0) {
	}

	die "";
}

sub delete  { (shift)->method('DELETE', @_) }
sub get     { (shift)->method('GET', @_) }
sub head    { (shift)->method('HEAD', @_) }
sub options { (shift)->method('OPTIONS', @_) }
sub patch   { (shift)->method('PATCH', @_) }
sub post    { (shift)->method('POST', @_) }
sub put     { (shift)->method('PUT', @_) }

sub _build_url {
	my $this = shift;
	my %args = @_;

	my $url = URI::URL->new();

	my %query_args = $url->query_form(
		$url->query_form,
		ref $args{query} eq 'HASH' ? %{$args{query}} :
		ref $args{query} eq 'ARRAY' ? @{$args{query}} :
		$args{query} ? die "" : ()
	);

	if ($url->full_path =~ // )
	my $path = $url->full_path
}

1;
