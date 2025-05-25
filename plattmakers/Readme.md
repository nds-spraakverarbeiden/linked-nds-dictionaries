# RDF index for Plattmakers dictionary

North Low Saxon aggregate dictionary, https://plattmakers.de/en. Also contains forms from other dialects, but apparently, systematically normalized towards North Low Saxon in spelling and pronounciation.

Compiled by [Marcus Buck](https://plattmakers.de/en/about-author), born in 1982 and grown up in a small village on the Stader Geest (Lower Saxony), cf. [doc/](doc). This largely seems to build on earlier (incl. digital?) dictionaries, and in many cases, sources are given, but not as literal excerpts. For the sake of our linking task, Plattmakers data is treated as original content, i.e., as copyright-protected.

Accordingly, we only provide lemma and URL, no actual information. Neither is such information used for the linking.

Build with `make`.

Build from scratch with `make refresh`.

## Build process

plattmakers2woewoe.tsv
<- plattmakers.tsv
	<- plattmakers.jsonl
		<- html
<- plattmakers2woewoe.a
	<- plattmakers2norm.a
	<- plattmakers2norm_lex.a

