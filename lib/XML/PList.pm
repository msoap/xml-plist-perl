package XML::PList;

use strict;
use warnings;

our $VERSION = '0.01';

sub new {
    my $self = {};
    return bless $self;
}

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

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012 by Sergey Mudrik

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10 or,
at your option, any later version of Perl 5 you may have available.

=cut
