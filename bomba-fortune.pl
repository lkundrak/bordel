use LWP::UserAgent;
use XML::Simple;

use warnings;
use strict;

my $wikiexport = 'http://pl.wikiquote.org/w/index.php?title=Specjalna:Eksport&action=submit';
my $ua = new LWP::UserAgent;
$ua->agent ('Mozilla/5.0');

binmode STDOUT, ':utf8';
print join "\n%", map {
	s/<br[^>]*>/\n/gi;
	s/''('*)//g;
	s/\*\*/\n\t -- /g;
	s/\*\s+/\n/g;
	$_;
} split /---*/, join "",
	grep { /\[\[.*Kapitan Bomba/ ... /\[\[/ and not /\[\[|wulgaryzmy/ }
	split (/\n/, XMLin ($ua->post ($wikiexport, [
		pages => 'Kartony',
		curonly => 1,
	])->content)->{page}{revision}{text}{content});
