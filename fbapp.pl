use WWW::Facebook::API;

my $client = new WWW::Facebook::API (
	desktop => 1,
	api_key => XXXXXXXXX
	secret => XXXXXXXXXx
);

$client->auth->get_session ( $client->auth->login ( 'sleep' => 1, browser => 'xdg-open',));

use Data::Dumper;

die Dumper $response = $client->fql->query( query => 'SELECT uid FROM page_fan WHERE page_id = 8064650479 AND uid > 0;' );


#foreach my $group (@{$client->groups->get( uid => 'uid')}) {
#	next unless $group->{name} =~ /Fedora/i;
#
#	print Dumper $client->users->get_info (
#		uids => $client->groups->get_members (gid => $group->{gid})->{members},
#		fields => [ qw/name pic_square/ ],
#	);
#}

