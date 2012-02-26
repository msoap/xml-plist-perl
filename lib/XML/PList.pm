package XML::PList;

use strict;
use warnings;
use Carp;

our $VERSION = '0.01';

# ------------------------------------------------------------------------------
sub new {
    my $class = shift;
    my $self = {};
    $self->{plist_filename} = shift;

    croak("plist filename required in new()") unless defined $self->{plist_filename};
    croak("plist '$self->{plist_filename}' not found or not read") unless -r $self->{plist_filename};

    return bless $self, $class;
}

# ------------------------------------------------------------------------------
sub parse {

}

1;

__END__

=head1 NAME

XML::PList - parse mac .plist files

=head1 SYNOPSIS

  use XML::PList;
  my $data = XML::PList->new('file.plist')->parse();

=head1 DESCRIPTION

Read mac plist files (xml for now)

=head2 EXPORT

None by default.

=head1 SEE ALSO

L<Mac::Tie::PList>,
L<Data::Plist>

=head1 AUTHOR

Sergey Mudrik, E<lt>sergey.mudrik@gmail.comE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10 or,
at your option, any later version of Perl 5 you may have available.

=cut
