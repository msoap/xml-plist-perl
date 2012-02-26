use strict;
use warnings;

use Test::More tests => 2;
use Test::Exception;

use XML::PList;

dies_ok { XML::PList->new('t/plists/test00_bin.plist')->parse() } 'expecting xml plist file';

my $plist_filename = 't/plists/test01_xml.plist';
my $plist = XML::PList->new($plist_filename);
lives_ok { my $plist_data = $plist->parse() } 'die if filename is not parse';
