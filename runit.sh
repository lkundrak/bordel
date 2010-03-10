set -e

# Generate all RPM packages
perl yumsudoku.pl

# Build solved puzzle
perl gamespec.pl <solved-board >solved1.spec
rpmbuild -bb --define "_rpmdir $PWD" solved1.spec

# Prove it
YUM6=$PWD yum -d8 -y -c yum.conf install noarch/solved1-0-0.noarch.rpm

# Build unsolved puzzle
perl gamespec.pl <unsolved-board >unsolved1.spec
rpmbuild -bb --define "_rpmdir $PWD" unsolved1.spec

# Prove it
YUM6=$PWD yum -d8 -y -c yum.conf install noarch/unsolved1-0-0.noarch.rpm
