SHELL=bash

all: pdt2woewoe.tsv

pddefns.tsv:
	wget -nc https://ereimer.net/plautdietsch/pddefns.htm -O - \
	| tee pddefns.htm \
	| perl -pe 's/\s+/ /g; s/</\n</g;' \
	| grep '<p' \
	| cut -f 2 -d '>' \
	| cut -f 1 -d '<' \
	| sed s/' \- '/'\t'/ \
	| sed s/'\/'/'\\\/'/g \
	| perl -pe 'use utf8; use URI::Escape qw( uri_escape ); s/[\r\n]*//g; my $$url=$$_; $$url=~s/\t.*//g; $$url=uri_escape($$url); $$_=$$_."\thttps://ereimer.net/plautdietsch/pddefns.htm#".$$url."\n";' \
	> pddefns.tsv
	
pdt2norm.a:
	fst-compiler-utf8 pdt2norm.fst pdt2norm.a

pdt2woewoe.tsv: 
	@if [ ! -e pdt2woewoe.tsv ]; then \
		pddefns.tsv pdt2norm.a pdt2woewoe.a
		cat pddefns.tsv \
		| python3 ../fst4conll.py pdt2woewoe.a \
		| sed -e s/' \([^ \t]*\)$$'/'\t\1'/ \
			  -e s/'\\:'/':'/g \
		> pdt2woewoe.tsv;\
	fi;

pdt2woewoe.a: pdt2norm.a
	fst-compiler-utf8 pdt2woewoe.fst pdt2woewoe.a
