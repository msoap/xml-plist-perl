#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;
use Test::Exception;

use XML::PList;

my $xml_string = join('', <DATA>);
my $plist = XML::PList->new(\$xml_string);
my $plist_data;
lives_ok { $plist_data = $plist->parse() } 'die if filename is not parse';
ok(ref($plist_data) eq 'ARRAY', 'result is array');

__DATA__
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
	<string>string value with &lt;tag&gt; &amp; symbols</string>
	<integer>123</integer>
	<true/>
	<date>2012-02-21T13:57:11Z</date>
</array>
</plist>
