package XML::PList;

use strict;
use warnings;

use Carp;
use XML::LibXML;
use MIME::Base64;

use Data::Dumper;

our $VERSION = '0.02';

# ------------------------------------------------------------------------------
sub new {
    my $class = shift;
    my $self = {};
    $self->{plist} = shift;

    if (ref($self->{plist}) eq '') {
        # is filename
        croak("plist filename required in new()") unless defined $self->{plist};
        croak("plist '$self->{plist}' not found or not read") unless -r $self->{plist};
    }

    return bless $self, $class;
}

# ------------------------------------------------------------------------------
sub parse {
    my $self = shift;

    my $result;

    my $dom = ref($self->{plist}) eq 'SCALAR'
              ? XML::LibXML->load_xml(string => ${$self->{plist}})
              : XML::LibXML->load_xml(location => $self->{plist});

    foreach my $node ($dom->documentElement()->childNodes()) {
        if ($node->nodeType == XML::LibXML::XML_ELEMENT_NODE
            && ($node->nodeName() eq 'dict' || $node->nodeName() eq 'array')
           )
        {
            $result = _parse_anything($node);
            last; # only one dict item at root of plist
        }
    }

    return $result;
}

# ------------------------------------------------------------------------------
sub _parse_anything {
    my $node = shift;

    if ($node->nodeName() eq 'dict') {
        return _parse_dict($node);
    } elsif ($node->nodeName() eq 'array') {
        return _parse_array($node);
    } elsif ($node->nodeName() eq 'string') {
        return $node->textContent();
    } elsif ($node->nodeName() eq 'integer') {
        return $node->textContent() + 0;
    } elsif ($node->nodeName() eq 'real') {
        return $node->textContent() + 0;
    } elsif ($node->nodeName() eq 'true') {
        return 1;
    } elsif ($node->nodeName() eq 'false') {
        return 0;
    } elsif ($node->nodeName() eq 'date') {
        return $node->textContent();
    } elsif ($node->nodeName() eq 'data') {
        return decode_base64($node->textContent());
    } else {
        croak('plist is invalid, find tag: ' . $node->nodeName());
    }
}

# ------------------------------------------------------------------------------
sub _parse_dict {
    my $dict_node = shift;

    my $state = 'value';
    my $key_name;

    my $result = {};

    foreach my $node ($dict_node->childNodes()) {
        next unless $node->nodeType == XML::LibXML::XML_ELEMENT_NODE;

        croak("parse error") if $node->nodeName() eq 'key' && $state eq 'key';
        croak("parse error") if $node->nodeName() ne 'key' && $state eq 'value';

        if ($node->nodeName() eq 'key' && $state eq 'value') {
            $state = 'key';
            $key_name = $node->textContent();
        }

        if ($node->nodeName() ne 'key' && $state eq 'key') {
            $state = 'value';
            $result->{$key_name} = _parse_anything($node);
        }
    }

    return $result;
}

# ------------------------------------------------------------------------------
sub _parse_array {
    my $array_node = shift;

    my $result = [];

    foreach my $node ($array_node->childNodes()) {
        next unless $node->nodeType == XML::LibXML::XML_ELEMENT_NODE;
        push @$result, _parse_anything($node);
    }

    return $result;
}

1;

__END__

=head1 NAME

XML::PList - parse mac .plist files

=head1 SYNOPSIS

  use XML::PList;

  # parse file
  my $data = XML::PList->new('file.plist')->parse();

  # parse string
  my $data = XML::PList->new(\'<?xml...<plist>...')->parse();

=head1 DESCRIPTION

Read mac plist files (xml only)

=head2 EXPORT

None by default.

=head2 DEPENDENCIES

XML::LibXML, MIME::Base64

=head1 SEE ALSO

L<Mac::Tie::PList>,
L<Data::Plist>,
L<Mac::PropertyList>

=head1 AUTHOR

Sergey Mudrik, E<lt>sergey.mudrik@gmail.comE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10 or,
at your option, any later version of Perl 5 you may have available.

=cut
