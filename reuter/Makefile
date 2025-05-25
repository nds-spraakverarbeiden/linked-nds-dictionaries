SHELL=bash
all: reuter2woewoe.tsv

reuter2woewoe.tsv: 
	@if [ ! -e reuter2woewoe.tsv ]; then \
		make reuter.tsv reuter2norm.a reuter2woewoe.a;\
		cat reuter.tsv \
		| python3 ../fst4conll.py reuter2woewoe.a \
		| sed -e s/' \([^ \t]*\)$$'/'\t\1'/ \
			-e s/'\\:'/':'/g \
		> reuter2woewoe.tsv;\
	fi;

reuter2woewoe.a: reuter2norm.a
	@if [ ! -e reuter2woewoe.a ]; then \
		if [ -e reuter2woewoe.a.gz ] ; \
			echo reuter2woewoe.a.gz '>' reuter2woewoe.a 1>&2;\
			gunzip reuter2woewoe.a.gz; \
		else \
			echo reuter2woewoe.fst '>' reuter2woewoe.a 1>&2;\
			fst-compiler-utf8 reuter2woewoe.fst reuter2woewoe.a;\
		fi;		
	fi;

reuter2norm.a:
	@if [ ! -e reuter2norm.a ]; then \
		fst-compiler-utf8 reuter2norm.fst reuter2norm.a;\
	fi;

reuter.tsv: reuter.jsonl
	cat reuter.jsonl \
	| jq '"\(.lemma)\t\(.url)\t\(.["Schreibweise(n)"])\t\(.Wortart)"' \
	| sed -e s/'\\t'/'\t'/g \
		  -e s/'"'//g \
	> reuter.tsv

html: 
	if [ ! -e html ]; then \
		make update_html;\
	fi;

update_html:
	@for i in {1..30000}; do \
		i=`echo '00000'$$i | perl -pe 's/.*(.....)$$/\1/;';`;\
		echo $$i 1>&2; \
		dir=html/`echo $$i | sed s/'^\(..\).*'/'\1'/g;`;\
		if [ ! -e $$dir ]; then mkdir -p $$dir; fi;\
		tgt=$$dir/$$i.html;\
		if [ ! -e $$tgt ]; then \
			if wget -nc "https://www.niederdeutsche-literatur.de/dwn/dwn_frw_he.php?W_ID="$$i -O $$tgt; \
			then echo $$tgt 1>&2;\
			else rmdir $$dir || ls $$tgt;\
			fi;\
		fi;\
		echo;\
	done;\
	
reuter.jsonl: html
	@if [ ! -e reuter.jsonl ]; then \
		for dir in html/*/; do \
			for html in $$dir/*.html; do \
				echo -n -e "\r"$$html `wc -l reuter.jsonl 2>/dev/null` 1>&2;\
				i=`basename $$html | sed s/'[^0-9]*'//g`;\
				nr=`echo $$i | sed s/'^0*'//`;\
				dir=`echo $$i | sed s/'^\(..\).*'/'\1'/g;`;\
				html=html/$$dir/$$i.html;\
				(echo -n '{ "url":"https://www.niederdeutsche-literatur.de/dwn/dwn_frw_he.php?W_ID='$$nr'", "lemma":';\
				xmllint --html --recover --xpath "//main//section[@id='info']//h3/span[@class='pld']/text()" $$html 2>/dev/null \
				| perl -pe 's/\s+/ /g;' \
				| perl -pe 's/^\s*(.*)\s*$$/"\1", /';\
				xmllint --html --recover --xpath "//main//section[@id='info']//table" $$html 2>/dev/null \
				| perl -pe ' s/<[\/]*br[\/]*>/ /g; s/\s+/ /g;' \
				| w3m -T text/html -dump -cols 500000000 \
				| egrep ':' \
				| sed s/'["'"'"']'//g \
				| perl -pe 's/\s*([^\n:]+)\s*:\s*([^\n:]+)\s*\n/"\1":"\2"\n/;' \
				| perl -pe 's/\n/, /g;' \
				| perl -pe 's/\s+/ /g;' \
				| perl -pe 's/^(.+),\s*$$/\1}/g;';\
				echo) | grep '}' || echo >& /dev/null; \
			done ;\
		done \
		| sed s/'", [0-9A-Za-z][^}]*'/'"'/g \
		| sed s/'":"[^"]*":".*'/'":"_"}'/g \
		| grep '"lemma":' \
		| grep -v '"lemma":"_"' \
		| jq -R "fromjson? | . " -c \
		| tee reuter.jsonl;\
	fi;



