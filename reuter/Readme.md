# Digital Reuter dictionary

RDF index file for the Mecklenburgian Fritz-Reuter-Wörterbuch by Peter Hansen, [Digitales Wörterbuch Niederdeutsch (DWN)](https://www.niederdeutsche-literatur.de/dwn), published online under [Die niederdeutsche Literatur](https://www.niederdeutsche-literatur.de).

DWN dictionaries are (implicitly) copyrighted, but this one is a re-edition of a work by C.F.Müller (1904): Reuter-Lexikon (see [here](https://www.niederdeutsche-literatur.de/dwn/index-frw.php)) which is in the public domain. At DWN, it has been subsequently extended with inflected forms and POS information from other, copyright-free works. But neither of these is used here. For reasons of copyright, we only maintain lemma form and URL.

In principle, we can provide the same level of linking for all DWN dictionaries, this includes a dictionary for Mecklenburgian-Western Pomeranian.

## Build process

reuter2woewoe.tsv
	<- reuter2norm.a
	<- reuter2woewoe.a
	<- reuter.tsv
		<- reuter.jsonl
			<- html

## Known issues

We do not support `make refresh` because it is likely to time out. We ran it on an adequately-sized server.