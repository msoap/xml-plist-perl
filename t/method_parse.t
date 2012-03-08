#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 9;
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

my $bad_xml_string = $xml_string . "is not xml";
dies_ok { XML::PList->new(\$bad_xml_string)->parse() } 'parsing invalid binary plist';

# string with entity and real type
$xml_string = join('', <DATA>);
lives_ok { $plist_data = XML::PList->new(\$xml_string)->parse() } 'parsing plutil with real type';
ok(ref($plist_data) eq 'HASH', 'result is hash');
ok($plist_data->{key1} eq 'string value with <tag> & symbols', 'result is string');
ok(sprintf("%0.2f", $plist_data->{key_is_real}) eq '3.14', 'result is real');

__DATA__
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>key1</key>
	<string>string value with &lt;tag&gt; &amp; symbols</string>
	<key>key2</key>
	<integer>123</integer>
	<key>key3</key>
	<true/>
    <key>key4</key>
    <date>2012-02-21T13:57:11Z</date>
    <key>key_is_real</key>
    <real>3.141592653589793</real>
</dict>
</plist>
