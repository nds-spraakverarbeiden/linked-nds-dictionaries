SHELL=bash

all: rdf-data

docx: 
	@if [ ! -e docx ]; then make update_docx; fi

rdf-data: 
	@if [ ! -e rdf-data ]; then \
		make docx;\
		python3 docx2rdf.py docx/woewoe-[A-Z]-[A-Z] -d rdf-data;\
	fi;

update_docx:
	@if [ ! -e docx ]; then mkdir docx; fi;\
	urls="https://ditschiplatt.de/wp-content/uploads/2019/12/W%C3%B6w%C3%B619-2-20190101c1-NeuberPeter-W%C3%B6hrnerW%C3%B6%C3%B6r-A-K.docx https://ditschiplatt.de/wp-content/uploads/2019/12/W%C3%B6w%C3%B619-3-20190101d1-NeuberPeter-W%C3%B6hrnerW%C3%B6%C3%B6r-L-Z.docx";\
	for url in $$urls; do \
		tgt=docx/`echo $$url | sed s/'.*\-\([A-Z]\-[A-Z]\.\)'/'woewoe-\1'/`;\
		if [ ! -e $$tgt ]; then \
			echo $$url '>' $$tgt 1>&2;\
			wget $$url -O $$tgt;\
			echo 1>&2;\
		fi;\
	done;\

	@for file in docx/*docx; do \
		dir=`echo $$file | sed s/'\.docx$$'//`;\
		if [ ! -d $$dir ]; then \
			echo $$file '>' $$dir 1>&2;\
			mkdir -p $$dir;\
			unzip $$file -d $$dir;\
		fi;\
	done