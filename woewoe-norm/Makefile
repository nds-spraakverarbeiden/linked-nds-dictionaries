all: woewoe.a woewoe2norm.a norm2woewoe.a
  
refresh:
	@for file in *.a woewoe-rdf.tsv; do \
		if [ -e $$file ]; then \
			rm $$file; \
		fi;\
	done;
	@make all

woewoe2norm.a: norm2woewoe.fst
	@if [ ! -e woewoe2norm.a ]; then \
		fst-compiler-utf8 norm2woewoe.fst woewoe2norm.a;\
	fi

norm2woewoe.a: norm2woewoe.fst
	@if [ ! -e norm2woewoe.a ]; then \
		fst-compiler-utf8 norm2woewoe.fst norm2woewoe.a -s;\
	fi;

woewoe.a: 
	@if [ ! -e woewoe.a ]; then \
		make woewoe-rdf.tsv;\
		echo woewoe-rdf.tsv '>' woewoe.fst 1>&2;\
		(cat woewoe-rdf.tsv \
		 | grep -v ' ' \
		 | sed -e s/'[<>,]'//g -e s/'[!%:._\-]'/'\\&'/g \
		 | sed -e s/'\([^\t]*\)\t\([^\t]*\)$$'/'\1 {[\\\t]\2}:<> | \\'/g;\
		 echo '\_ {[\	]\_}:<>';\
		) \
		> woewoe.fst;\
		echo woewoe.fst '>' woewoe.a 1>&2;\
		fst-compiler-utf8 woewoe.fst woewoe.a;\
	fi;

woewoe-rdf.tsv:
	@cd ../woewoe-rdf; make;
	
	@if [ ! -e woewoe-rdf.tsv ]; then \
		 echo ../woewoe-rdf/rdf-data/woewoe_nds_rdf.ttl '>' woewoe-rdf.tsv 1>&2;\
		 \
		arq --data ../woewoe-rdf/rdf-data/woewoe_nds_rdf.ttl --query woewoe2tsv.sparql --results=TSV \
		| sed s/'"'/'\t'/g \
		| cut -f 2,7 \
		| grep -v '?' \
		| egrep '^[\t]*[a-zA-Z]' \
		| sort -d -f -u \
		> woewoe-rdf.tsv;\
	fi;

	@# we only return the longset substring not separated by |, use cut -f 2,5,7 to get the full string of forms
