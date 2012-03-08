#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;
use Test::Exception;

use XML::PList;

dies_ok { XML::PList->new('t/plists/test00_bin.plist')->parse() } 'expecting xml plist file';

my $plist_filename = 't/plists/test01_xml.plist';
my $plist = XML::PList->new($plist_filename);
my $plist_data;
lives_ok { $plist_data = $plist->parse() } 'die if filename is not parse';
ok(ref($plist_data) eq 'HASH', 'result is hash');

# from string
my $is_mac = $^O eq 'darwin';
my $xml_string = $is_mac ? qx'plutil -convert xml1 -o - t/plists/test00_bin.plist' : join('', <DATA>);
lives_ok { XML::PList->new(\$xml_string)->parse() } 'parsing binary plist via plutil';
$xml_string = $xml_string . "is not xml";
dies_ok { XML::PList->new(\$xml_string)->parse() } 'parsing invalid binary plist';

__DATA__
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>root_dict</key>
	<string>string value with &lt;tag&gt; &amp; symbols</string>
	<key>key2</key>
	<integer>123</integer>
	<key>key3</key>
	<true/>
	<key>key4</key>
	<date>2012-02-21T13:57:11Z</date>
</dict>
</plist>
