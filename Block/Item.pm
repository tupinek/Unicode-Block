package Unicode::Block::Item;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use Error::Pure qw(err);
use Unicode::Char;

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Hexadecimal number.
	$self->{'hex'} = undef;

	# Length of hex number.
	$self->{'hex_length'} = 4;

	# Process parameters.
	set_params($self, @params);

	# Check hex number.
	# TODO Check hex.
	if (! $self->{'hex'}) {
		err "Parameter 'hex' is bad.";
	}

	# Object.
	return $self;
}

# Get base number.
sub base {
	my $self = shift;
	my $base = substr $self->hex, 0, -1;
	return 'U+'.$base.'x';
}

# Get hex number.
sub hex {
	my $self = shift;
	return sprintf '%0'.$self->{'hex_length'}.'x',
		CORE::hex $self->{'hex'};
}

# Get last number.
sub last_hex {
	my $self = shift;
	return substr $self->{'hex'}, -1;
}

# Get value.
sub value {
	my $self = shift;
	if (! exists $self->{'u'}) {
		$self->{'u'} = Unicode::Char->new;
	}
	return $self->{'u'}->u($self->{'hex'});
}

1;
