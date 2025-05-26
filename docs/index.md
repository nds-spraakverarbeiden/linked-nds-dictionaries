# Linked Low German dictionaries: RDF conversion and linking of Low German dictionaries

With this repository, we provide a set of cross-dialectally linked Low German (Low Saxon) online dictionaries as a linked lexical knowledge graph in OntoLex/RDF.
This has a practical motivation, to provide a machine- and human-readable multidialectal dictionary, and serve as a "digital Rosetta stone" that unifies lexical materials from different dialects through linking dictionaries and mapping corresponding words without the need for a standard variety.

Licence to be confirmed.

When using, referring to or reporting this data, please cite

<table>
	<tr><td>
Christian Chiarcos and Tabea Gröger and Christian Fäth (2025), Putting Low German on the Map (of Linguistic Linked Open Data), in Proceedings of the 5th Conference on Language, Data and Knowledge (LDK-2025), 2025, Sep 9-11, Naples, Italy.
</td></tr>
</table>

## Background

Low German (Low Saxon, ISO 639-2 `nds`) is a regional language protected under the European Charter for Regional or Minority Languages (ECRML), spoken primarily in Northern Germany and in the Western Netherlands, closely related to High German, Dutch and Frisian. During the Middle Ages, it has been a lingua franca around the Baltic Sea, expanded widely into areas with formerly Slavic, Danish or Frisian language, and it had a strong and lasting impact on modern Scandinavian languages. However, after the 16th c., it has been gradually replaced as a language of administration and literature by the emerging national languages, and fragmented into various dialects. Without a written standard and without a prestige variety to adhere to, existing language resources (mostly literature and dictionaries) currently take strongly regional focus.

Aside from representing hurdles in the promotion and use of the language in the digital sphere, on the book market or with respect to the creation of didactic materials, this also represents a limiting factor for the development of NLP technologies, which -- to this day --, practically do not exist for Low German.

Due to the lack of training data, the cross-dialectal linking provided here is done automatically and on formal grounds only. It may thus contain errors. Our approach also provides a confidence score, where higher scores indicate greater confidence. For technical details, see the accompanying paper.

## Content

We provide an excerpt from WöWö (Low German lemmas and German translations). For reasons of copyright, no other information from other dictionaries has been used or is provided except for the lookup URL and the lemma form.

- **(human-readable) [HTML visualization](woewoe-links.html)**
	- lemmas and glosses from [WöWö dictionary (Wöörner Wöör)](https://ditschiplatt.de/woehrner-woeoer/) (North Low Saxon, Dithmarschen)
	- automated linking with
		- [Fritz Reuter dictionary at DWN](https://www.niederdeutsche-literatur.de/dwn/index-frw.php) (East Low German, Mecklenburgian)
		- [Plattmakers dictionary](https://plattmakers.de/) (North Low Saxon, North Hanoveranian) 
		- [Westfälisches Wörterbuch](https://www.mundart-kommission.lwl.org/de/forschung/westfaelisches-woerterbuch/), hosted at the [Trier Wörterbuchnetz](https://www.woerterbuchnetz.de/WWB) (Westphalian)
		- [Plautdietsch dictionary](https://ereimer.net/plautdietsch/pddefns.htm) (Mennonite Low German)
		- linking with the Twents dialecticon has been removed from HTML because they do not provide stable URLs.
- **(machine-readable) lexical knowledge graph** in RDF/Turtle, using the OntoLex vocabulary
	- [WöWö excerpt (RDF)](woewoe.ttl) (lemma and German translation)
	- Links for
		- [Fritz Reuter dictionary (RDF index file)](reuter-links.ttl) (Mecklenburgian)
		- [Plattmakers dictionary (RDF index file)](plattmakers-links.ttl) (North Low Saxon, North Hanoveranian)
		- [Westfälisches Wörterbuch (RDF index file)](wwb-links.ttl) (Westphalian from Germany)
		- [Plautdietsch dictionary (RDF index file)](pdt-links.ttl) by Herman Rempel (1984-1995), the Mennonite Literary Society (1984-1995), mennolink.org (1998-2006), and Eugene Reimer (2006-2007) (Mennonite Low German, emmigrant variety of East Low German)
		- [Twents dialecticon (RDF index file)](twents-links.ttl) (Westphalian from the Netherlands)
			- **warning**: As observed in May 2025, the original Twents dialecticon URLs have been changed since this file was created, so that most lemmas will not resolve correctly. Use at your own risk.
	- [complete dump](all.ttl) (except Twents)
- **developer resources at [GitHub](https://github.com/nds-spraakverarbeiden/linked-nds-dictionaries), incl.
	- build scripts for WöWö excerpt (DOCX -> OntoLex)
	- SFST scripts for normalization (against North Markian) and WöWö linking
	- OntoLex conversion for linked external dictionaries (lemmas and lemma URLs, only)
	- querying and pruning routine for generating HTML (OntoLex -> HTML)
