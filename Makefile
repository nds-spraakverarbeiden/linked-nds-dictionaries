SHELL=bash

all: release

release: 
	if [ ! -e release ]; then make update_release; fi

publish: release
	@for file in release/*.ttl release/woewoe-links.html; do \
		if [ -e $$file ]; then \
			if [ ! -e docs ]; then mkdir docs; fi;\
			tgt=docs/`basename $$file`;\
			if [ -e $$tgt ]; then \
				echo error: file $$tgt found, please remove manually 1>&2;\
				exit 1;\
			fi;\
			cp $$file $$tgt;\
			git add $$tgt; \
			echo "git commit "$$tgt 1>&2;\
			git commit -a -m "publish "`basename $$tgt`;\
			echo "git push "$$tgt 1>&2;\
			git push;\
		fi;\
	done;

	@tgt=docs/woewoe.ttl;\
	 for file in woewoe-rdf/rdf-data/*.ttl; do \
	 	echo $$file '>>' $$tgt 1>&2;\
		cat $$file;\
		echo;\
		echo;\
	 done \
	 > $$tgt;\
	 git add $$tgt;\
	 echo "git commit "$$tgt 1>&2;\
	 git commit -a -m "publish "`basename $$tgt`;\
	 echo "git push "$$tgt 1>&2;\
	 git push;

update_release: 
	@echo make update_release will update the release/ directory. 1>&2
	@echo "for publishing your data online, don't forget to run make publish" 1>&2;
	@echo 1>&2;

	@if [ ! -e release ]; then \
		mkdir release; \
	 else \
	 	echo updating release/, keep existing files 1>&2;\
	 	echo for a fresh built from scratch, delete target files, first 1>&2;\
	 	echo 1>&2;\
	 fi;

	 @for dir in woewoe-rdf woewoe-norm plattmakers reuter twents woerterbuchnetz plautdietsch; do \
	 	cd $$dir; make; cd -;\
	 done;

	 @src=woerterbuchnetz/wfael2woewoe.tsv;\
	  tgt=release/wwb-links.ttl;\
	  if [ ! -e $$tgt ]; then \
	 	 echo $$src '>' $$tgt 1>&2;\
		 python3 tsv2links.py $$src \
		 	-c -b https://www.woerterbuchnetz.de/WWB -f 0 -t 1 -n 5 -t 6 -lt wep \
		 > $$tgt;\
		 echo 1>&2;\
	  fi;

	 @src=plattmakers/plattmakers2woewoe.tsv;\
	  tgt=release/plattmakers-links.ttl;\
	  if [ ! -e $$tgt ]; then \
	 	 echo $$src '>' $$tgt 1>&2;\
		 python3 tsv2links.py $$src \
		 	-c -b https://plattmakers.de -f 0 -t 1 -n 5 -t 6 -lt 'nds-x-nort3307' \
		 > $$tgt;\
		 echo 1>&2;\
	  fi;

	 @src=reuter/reuter2woewoe.tsv;\
	  tgt=release/reuter-links.ttl;\
	  if [ ! -e $$tgt ]; then \
	 	 echo $$src '>' $$tgt 1>&2;\
		 python3 tsv2links.py $$src \
		 	-c -b https://www.niederdeutsche-literatur.de/dwn/dwn_frw_he.php -f 0 -t 1 -n 5 -t 6 -lt 'nds-x-meck1239' \
		 > $$tgt;\
		 echo 1>&2;\
	  fi;

	 @src=twents/twents2woewoe.tsv;\
	  tgt=release/twents-links.ttl;\
	  if [ ! -e $$tgt ]; then \
	 	 echo $$src '>' $$tgt 1>&2;\
		 python3 tsv2links.py $$src \
		 	-c -b https://twentswoordenboek.nl/ -f 0 -u 1 -n 4 -t 5 -lt 'twd' \
		 > $$tgt;\
		 echo 1>&2;\
	  fi;

	 @src=plautdietsch/pdt2woewoe.tsv;\
	  tgt=release/pdt-links.ttl;\
	  if [ ! -e $$tgt ]; then \
	 	 echo $$src '>' $$tgt 1>&2;\
		 python3 tsv2links.py $$src \
		 	-c -b https://ereimer.net/plautdietsch/pddefns.htm -f 0 -u 2 -n 4 -t 5 -lt 'pdt' \
		 > $$tgt;\
		 echo 1>&2;\
	  fi;

	  @for file in release/*ttl; do \
	      echo -n validate $$file ..' ' 1>&2;\
	  	  if rapper -i turtle $$file >/dev/null 2>/dev/null; then \
		 	echo ok 1>&2;\
		 else \
		 	echo failed 1>&2;\
		 	echo '   ERROR: '$$file' is not a valid RDF/TTL file, renamed to '$$file.invalid 1>&2;\
		 	mv $$file $$file.invalid;\
		 fi;\
	   done;\
	   echo 1>&2;\

	@data=`for file in release/*.ttl woewoe-rdf/rdf-data/*ttl; do \
			echo ' --data' $$file;\
			echo -n $$file' ' 1>&2;\
			done;`;\
	echo '>' release/woewoe-links.json 1>&2;\
	arq $$data --query query.sparql --results=JSON > release/woewoe-links.json;\
	echo release/woewoe-links.json '>' release/woewoe-links.html 1>&2;\
	python3 arq_json2html.py release/woewoe-links.json > release/woewoe-links.html;\
	# no, these can't be rendered by GitHub \
	#echo release/woewoe-links.html '>' release/woewoe-links.md 1>&2;\
	#pandoc release/woewoe-links.html -t markdown > release/woewoe-links.md;

	@# Note: even though we process and convert Twents data, this has been excluded from the release because of URL instability;\
	 #       to re-enable Twents linking, update query.sparql, delete release/ and run make release


src: 
	@for dir in woewoe-rdf woewoe-norm woerterbuchnetz plattmakers reuter twents plautdietsch; do \
		echo make $$dir 1>&2;\
		cd $$dir; make; \
		cd -;\
		echo 1>&2;\
	done;

