SHELL=bash

all: twents2woewoe.tsv

refresh:
	@for file in *.tsv *.a; do; \
		if [ -e $$file ]; then rm $$file; fi;\
	done;
	@cd ../woewoe-norm; make;
	@make all

twents2woewoe.tsv: 
	@if [ ! -e twents2woewoe.tsv ]; then \
		make twents.tsv twents2norm.a twents2woewoe.a; \
		echo twents.tsv '>' twents2woewoe.tsv; \
		cat twents.tsv \
		| python3 ../fst4conll.py twents2woewoe.a \
		| sed -e s/' \([^ \t]*\)$$'/'\t\1'/ \
			  -e s/'\\:'/':'/g \
		> twents2woewoe.tsv;\
	fi;

twents2woewoe.a: twents2norm.a
	fst-compiler-utf8 twents2woewoe.fst twents2woewoe.a

twents2norm.a: twents2norm.fst
	fst-compiler-utf8 twents2norm.fst twents2norm.a

twents.tsv: 
	if [ ! -e html ]; then make html; fi
	for file in html/*html; do \
		base_url=https://twentswoordenboek.nl/lemmas/id/`basename $$file | cut -f 1 -d .`;\
		python3 html2tsv.py $$file $$base_url;\
	done \
	| tee twents.tsv

# this takes long, so, you can use update_html for incremental updates
html: 
	if [ ! -e html ]; then \
		mkdir html;\
		make update_html;\
	fi;

# as of 2025-03-15, the last entry is DMNI.html
# this goes on for 2,5 days 
update_html:
	@for w in {A..E}; do \
			for x in {A..Z}; do \
				for y in {A..Z}; do \
					for z in {A..Z}; do \
						src=$$w$$x$$y$$z; \
						tgt=html/$$src.html;\
						if [ ! -e $$tgt ]; then \
							echo $$src '>' $$tgt 1>&2;\
	 						curl 'https://twentswoordenboek.nl/lemmas/id/'$$src \
	 							-H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:95.0) Gecko/20100101 Firefox/95.0' \
	 							-H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' \
	 							-H 'Accept-Language: en-US,en;q=0.5'     \
	 							-H 'Accept-Encoding: gzip, deflate, br'     \
	 							-H 'Connection: keep-alive'     \
	 							-H 'Upgrade-Insecure-Requests: 1'     \
	 							-H 'Sec-Fetch-Dest: document'     \
	 							-H 'Sec-Fetch-Mode: navigate'     \
	 							-H 'Sec-Fetch-Site: none'     \
	 							-H 'Sec-Fetch-User: ?1'  \
	 							--output - \
	 							| gunzip - \
	 							> $$tgt;\
	 						echo 1>&2;\
	 						sleep $$(echo `echo $$RANDOM | sed s/'.*\(.\)$$'/'\1'/` / 3 +1 | bc);\
						fi;\
					done;\
				done;\
			done;\
		done;\
	

