#!/usr/bin/perl

<STDIN> =~ /^9$/ or die 'Unsupported board size';

foreach my $row (1..9) {
	my $line = <STDIN>;
	foreach my $col (1..9) {
		my $letter;
		$line =~ s/^(.)// and $letter = $1;
		if ($letter) {
			print "Requires: value-$col-$row-$letter\n";
		} else {
			print "Requires: cell-$col-$row\n";
		}
	}
	print "\n";
}

my $name = (shift @ARGV or 'puzzle');
print <<EOF;
Name: $name
Version: 0
Release: 0
Summary: Sudoku Puzzle
Group: Picoviny
License: EULA
BuildArch: noarch

\%description
\%{summary}

\%files
EOF
