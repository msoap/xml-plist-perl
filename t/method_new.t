#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;
use Test::Exception;

use XML::PList;

my $plist_filename = 't/plists/test01_xml.plist';
my $plist = XML::PList->new($plist_filename);
isa_ok($plist, 'XML::PList');
dies_ok { XML::PList->new() } 'expecting to die without filename';
dies_ok { XML::PList->new('this not exists file') } 'expecting to die if filename not exists';
lives_ok { XML::PList->new($plist_filename) } 'die if filename not exists';
