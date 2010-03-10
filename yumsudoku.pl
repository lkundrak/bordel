#!/usr/bin/perl

sub block
{
	my $col = shift;
	my $row = shift;

	return (
		# which block
		int(($row-1)/3)*3 + (int(($col-1)/3)+1),
		($col-1)%3+1,	# column in block
		($row-1)%3+1	# row in block
	);
}

sub pkg
{
	my $col = shift;
	my $row = shift;
	my $val = shift;
	my ($block, $brow, $bcol) = block ($col, $row);

	my $specfile = '';

	$specfile .=  "Name: value-$col-$row-$val\n";
	$specfile .=  "Provides: cell-$col-$row\n";
	$specfile .=  "Provides: block-$block-$bcol-$brow-$val\n";

	# Conflict with everything of the same value in the same row:
	foreach my $c (1..9) {
		$c == $col and next;
		$specfile .=  "Conflicts: value-$c-$row-$val\n";
	}

	# Conflict with everything of the same value in the same column:
	foreach my $r (1..9) {
		$r == $row and next;
		$specfile .=  "Conflicts: value-$col-$r-$val\n";
	}

	# Conflict with the same value within the same block
	foreach my $c (1..3) {
		foreach my $r (1..3) {
			$c == $bcol and $r == $brow and next;
			$specfile .=  "Conflicts: block-$block-$c-$r-$val\n";
		}
	}

	# Usual stuff
	$specfile .=  "Version: 0\n";
	$specfile .=  "Release: 0\n";
	$specfile .=  "Summary: Some Sudoku Shit\n";
	$specfile .=  "Group: Picoviny\n";
	$specfile .=  "License: EULA\n";
	$specfile .=  "BuildArch: noarch\n";
	$specfile .=  "\n";
	$specfile .=  "\%description\n";
	$specfile .=  "\%{summary}\n";
	$specfile .=  "\n";
	$specfile .=  "\%files\n";

	return $specfile;
}

mkdir "noarch";

# Generate files
foreach my $col (1..9) {
	foreach my $row (1..9) {
		foreach my $val (1..9) {
			my $spec = "value-$row-$col-$val.spec";
			open (SPEC, ">$spec") or die $!;
			print SPEC pkg ($row, $col, $val);
			close (SPEC);
			system ("rpmbuild -bb --define \"_rpmdir \$PWD\" $spec") and die;
		}
	}
	print "\n";
}
