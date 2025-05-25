SHELL=bash

all: plattmakers2woewoe.tsv

refresh:
	@for file in *.tsv *.a *.a.gz *jsonl; do; \
		if [ -e $$file ]; then rm $$file; fi;\
	done;
	@cd ../woewoe-norm; make;
	@make all

plattmakers2woewoe.tsv: 
	@if [ ! -e plattmakers2woewoe.tsv ]; then \
		make plattmakers.tsv plattmakers2norm.a plattmakers2woewoe.a;\
		echo plattmakers.tsv '>'  plattmakers2woewoe.tsv 1>&2;\
		cat plattmakers.tsv \
		| python3 ../fst4conll.py plattmakers2woewoe.a \
		| sed -e s/' \([^ \t]*\)$$'/'\t\1'/ \
			-e s/'\\:'/':'/g \
		> plattmakers2woewoe.tsv;\
	fi;

plattmakers2woewoe.a: 
	@if [ ! -e plattmakers2woewoe.a ]; then \
		if [ -e plattmaters2woewoe.a.gz ]; then \
			echo 'plattmakers2woewoe.a.gz > plattmakers2woewoe.a' 1>&2;\
			gunzip plattmakers2woewoe.a.gz; \
		else \
			make plattmakers2norm.a plattmakers2norm_lex.a;\
			echo plattmakers2woewoe.fst '>' plattmakers2woewoe.a 1>&2;\
			fst-compiler-utf8 plattmakers2woewoe.fst plattmakers2woewoe.a;\
		fi;\
	fi;

plattmakers2norm.a: plattmakers2norm.fst
	@if [ ! -e plattmakers2norm.a ]; then \
		echo plattmakers2norm.fst '>' plattmakers2norm.a 1>&2;\
		fst-compiler-utf8 plattmakers2norm.fst plattmakers2norm.a;\
	fi;

plattmakers2norm_lex.a: plattmakers2norm_lex.fst
	@if [ ! -e plattmakers2norm_lex.a ]; then \
		echo plattmakers2norm_lex.fst '>' plattmakers2norm_lex.a 1>&2;\
		fst-compiler-utf8 plattmakers2norm_lex.fst plattmakers2norm_lex.a;\
	fi;

html: 
	@if [ ! -e html ]; then \
		make update_html;\
	fi;

update_html:
	if [ ! -e html ]; then mkdir html; fi;
	for l1 in {a..w} {y..z}; do \
		if [ ! -e html/$$l1 ]; then mkdir html/$$l1; fi;\
		(cd html/$$l1;\
		paths=`wget -nc https://plattmakers.de/de/abc/$$l1 -O - 2>/dev/null \
				| perl -pe 's/\s+/ /g; s/(<a href=)/\n\1/g; s/"/'"'"'/g;' \
				| cut -f 2 -d "'" \
				| egrep '^/de/abc/'$$l1'[a-z]$$' \
				| sort -u`;  \
		for path in $$paths; do \
			urls=`wget -nc https://plattmakers.de$$path -O - 2>/dev/null  \
					| xmllint --html --recover --xpath "//div[@class='alphabetical_index']/ul[2]/li/a/@href" - 2>/dev/null \
					| cut -f 2 -d '"' \
					| egrep '^/de/[0-9][0-9]*/'`; \
			for url in $$urls; do \
				tgt=`basename $$(dirname $$url)`_`basename $$url`.html;\
				if [ ! -e $$tgt ]; then wget -nc https://plattmakers.de$$url -O $$tgt; fi;\
			done;\
		done;\
		) || echo error: issue with https://plattmakers.de/de/abc/$$l1 1>&2; \
	done;\

plattmakers.jsonl: 
	@if [ ! -e plattmakers.jsonl ]; then \
		make html;\
		for dir in html/*/; do \
			for file in $$dir/*.html; do \
				(\
				echo -n '{ "meta": ';\
				xmllint --html --recover --encode utf-8 --xpath "//script[@type='application/ld+json'][1]/text()" $$file 2>/dev/null \
				| sed -e s/'<!\[CDATA\['//g -e s/'\]\]>'//g \
				| egrep . \
				| perl -pe 'use utf8; s/} {/}, {/g; s/\s+/ /g;';\
				\
				echo -n ', "pronunciation":"';\
				xmllint --html --recover --encode utf-8 --xpath "//div[@class='word-head']//div[@class='pronunciation'][1]//span[@class='IPA'][1]/text()" $$file 2>/dev/null \
				| perl -pe 'use utf8; s/\s+//g';\
				echo -n '"';\
				\
				echo -n ', "type":"';\
				xmllint --html --recover --encode utf-8 --xpath "//div[@class='word-head']//span/a[starts-with(@href,'/de/glossary')][1]/@href" $$file 2>/dev/null \
				| perl -pe 'use utf8; s/\s+//g; s/.*[#\/]//g;'; \
				#echo -n '"'; # included in href attrib ;) \
				\
				echo -n ', "syll":"';\
				xmllint --html --recover --encode utf-8 --xpath "//div[@class='word-head']//div[contains(span[1]/text(),'Silbentrennung:')][1]/span[2]/text()" $$file 2>/dev/null \
				| perl -pe 'use utf8; s/\n//g;'; \
				echo -n '"';\
				\
				echo -n ', "translations": ["';\
				xmllint --html --recover --encode utf-8 $$file --xpath "//div[@class='translation_short']" 2>/dev/null \
				| perl -pe 'use utf8; s/\s+/ /g; s/<\/div>/<\/div>\n/g;' \
				| perl -pe 'use utf8; s/^(.*lang="([a-z]+)".*)$$/\1@\2/;' \
				| perl -pe "use utf8; s/<[^>]*>//g; s/.*>//g; s/<[^@]*//g; s/ +/ /g; s/ @/'@/g; s/^ ?([^ \n])/'\1/g;" \
				| perl -pe 'use utf8; s/\n/<br>/g;' \
				| perl -pe "use utf8; s/(@[a-z]+)<br>(')/\1"'"'", "'"'"\2/g; s/<br>//g;"; \
				echo -n '"]';\
				echo '}' \
				) | jq . 2>/dev/null | perl -pe 'use utf8; s/\s+/ /g;';\
				echo;\
				echo -e -n `wc -l plattmakers.jsonl` $$file '                         ' "\r" 1>&2;\
			done;\
			echo 1>&2;\
		done \
		| python3 fix-encoding.py -s \
		> plattmakers.jsonl;\
	fi;

plattmakers.tsv: plattmakers.jsonl
	@if [ ! -e plattmakers.tsv ]; then \
		echo plattmakers.jsonl '>' plattmakers.tsv 1>&2;\
		cat plattmakers.jsonl \
		| jq '"\(.meta[0].name)\t\(.meta[0].url)\t\(.pronunciation)\t\(.type)"' \
		| sed -e s/'\\t'/'\t'/g \
			  -e s/'"'//g \
			  -e s/'Definition von '//g \
		> plattmakers.tsv;\
	fi;
