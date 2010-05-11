rm -f *php

R=http://coltman.bloguje.cz/
wget -qO - $R |LANG=C sed -n 's/^<a href="\([^"]*\).PHPS[^"]*">Koment.*<\/a>/\1/p' |
while read E
do
	lynx -dump "$R$E" |awk '
		/linkuj.cz/ {e=0; next}
		/bloguje.cz$/ {e=1; getline; next}
		/^[0-9][0-9].[0-9][0-9].[0-9][0-9][0-9][0-9]/ {next}
		{if (e) {gsub ("^ *", ""); print}}
		/Zapsal:/ {
			gsub (".*coltman.....", "\t-- Honza ");
			gsub (".* ", "&, ");gsub (" , ", ", ");
			print;
		}
	' >$E
	echo -e '\t'"<$R$E>" >>$E
done

xargs rm <<BRAK
	656062-normalni-nedele.php
	656068-uprava-zakona-o-vysokych-skolach.php
	656069-pingpong.php
	656071-work-or-don-t-work-this-is-the-question.php
	656072-perl-vs-mysql.php
	672527-kde-domov-muj.php
	722708-cesta-na-devinskou-kobylu-sandberg-a-devin.php
	746597-log-fingerprint-patch-openssh.php
	761771-pottenburg-a-konigswarte.php
	779661-kdysi-davno.php
	817880-bez-titulku.php
BRAK

for F in *.php
do
	cat $F
	echo '%'
done >honza.fortunes

cat >>honza.fortunes <<PRERELEASE
13:50 <wwwnick> jedine svetlo na zemi jsou tvoje oci
13:51 <wwwnick> kdyz se do nich divam tak se cely svet jen toci
13:51 <wwwnick> stesti utece jako z piva pena
13:51 <wwwnick> zmizi tam kde laska seda
13:51 <wwwnick> moje posledni prani pred smrti
13:51 <wwwnick> by bylo mit te v naruci
13:51 <wwwnick> divat se ti do oci
13:51 <wwwnick> cekat ze se osud otoci

Tue May 11 EDT 2010
PRERELEASE
