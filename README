XML-PList
=========

NAME
----

XML::PList - parse mac os .plist files

SYNOPSIS
--------

    use XML::PList;

    # parse file
    my $data = XML::PList->new('file.plist')->parse();

    # parse string
    my $data = XML::PList->new(\'<?xml...<plist>...')->parse();

DESCRIPTION
-----------
parse mac os .plist (only xml) files

METHODS
-------

###new
create XML::PList object

    my $plist = XML::PList->new($filename);
    my $plist = XML::PList->new(\$string_with_plist_xml);

    # parse binary plist via external utility plutil (on Mac OS only)
    my $xml_string = qx'plutil -convert xml1 -o - binary.plist';
    my $plist = XML::PList->new(\$xml_string);

###parse
parse plist xml into perl structure

    my $data = $plist->parse();

INSTALLATION
------------
To install this module type the following:

    perl Makefile.PL
    make
    make test
    make install

DEPENDENCIES
------------
This module requires these other modules and libraries:

- XML::LibXML
- MIME::Base64

SEE ALSO
--------

- Mac::Tie::PList
- Data::Plist

AUTHOR
------
Copyright (C) 2012 by Sergey Mudrik

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
