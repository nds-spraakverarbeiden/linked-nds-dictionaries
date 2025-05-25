all: 
	cd ../woewoe-norm; make
	make wfael2woewoe.tsv

refresh:
	cd ../woewoe-norm; make
	for file in *.tsv *.a *.json xml/ src/ ; do \
		if [ -e $$file ]; then rm -rf $$file; fi;\
	done;
	make wfael2woewoe.tsv

wfael2woewoe.tsv: 
	@if [ ! -e wfael2woewoe.tsv ]; then \
		wfael2woewoe.a wfael2norm.a wfael.tsv
		cat wfael.tsv \
		| python3 ../fst4conll.py wfael2woewoe.a \
		| sed -e s/' \([^ \t]*\)$$'/'\t\1'/ \
			  -e s/'\\:'/':'/g \
		> wfael2woewoe.tsv;\
	fi;

wfael2woewoe.a: 
	@if [ ! -e wfael2woewoe.a ]; then \
		if [ -e wfael2woewoe.a.gz ]; then \
			echo wfael2woewoe.a.gz '>' wfael2woewoe.a 1>&2;\
			gunzip wfael2woewoe.a.gz;\
		else \
			make wfael2norm.a;\
			fst-compiler-utf8 wfael2woewoe.fst wfael2woewoe.a;\
		fi;\
	fi;\

wfael2norm.a: norm2wfael.fst
	fst-compiler-utf8 norm2wfael.fst wfael2norm.a

# generate a TSV file with LEMMA GRAMM URL
wfael.tsv: wfael.json
	@if [ ! -e wfael.tsv ]; then \
		(echo "<table>"; \
		  cat wfael.json \
		  | jq '.[] | "<tr><td>\(.lemma)<td>\(.wbnetzlink)<td>\(.spans[0]|.[1])<td>\(.gram)</tr>"'\
		) \
		| sed s/'"'//g \
		| xmllint --html --xmlout --recover --encode utf-8 - 2>/dev/null \
		| pandoc -f html - -t markdown \
		| grep https \
		| uniq \
		| sed -e s/'   *'/'\t'/g \
			  -e s/'\\'//g \
			  -e s/'^\s*'// \
		> wfael.tsv;\
	fi;

wfael.json: lemmas.json xml
	python3 merge.py lemmas.json xml/*xml \
	> wfael.json

# enthält lemma, POS und Verweise, keine Möglichkeit, auf den Text zuzugreifen
lemmas.json:
	@# get lemmata; \
	curl "https://api.woerterbuchnetz.de/open-api/dictionaries/WWB/lemmata/*" \
	> lemmas.json

src: update_src

update_src: lemmas.json
	if [ ! -e src ]; then mkdir src; fi;
	for a in {A..Z}; do \
		for n in {0..500}; do \
			n=`echo $$n*2 | bc`;\
			n=$$a`echo 00000$$n | sed s/'.*\(....\)$$'/'\1'/;`1;\
			if egrep $$n lemmas.json >/dev/null; then \
				tgt=src/$$n.html;\
				if [ ! -s $$tgt ]; then \
					url='https://woerterbuchnetz.de/?sigle=WWB&lemid='$$n;\
					echo $$url '>' $$tgt 1>&2;\
					nice /opt/google/chrome/chrome --headless $$url --disable-gpu --dump-dom > $$tgt;\
					echo 1>&2;\
					sleep $$(echo `echo $$RANDOM | sed s/'.*\(.\)$$'/'\1'/` / 3 +1 | bc);\
				fi;\
			fi;\
		done;\
	done

update_xml: 
	if [ ! -e xml ]; then mkdir xml; fi
	for src in src/*.html; do \
		tgt=xml/`basename $$src | sed s/'\.html'//`.xml;\
		if [ ! -e $$tgt ]; then \
			echo $$src '>' $$tgt 1>&2;\
			cat $$src \
			| xmllint -html -xmlout -recover - 2>/dev/null \
			> $$tgt;\
		fi;\
	done;\

xml: update_xml

