#!/bin/bash

echo "synopsis: $0 SRC.URL TGT.URL FILE[1..n]" 1>&2;
echo "          helper script to update an existing URL schema to a new one" 1>&2;
echo "          SRC.URL source URL, start with protocol (http://, https://, ...)" 1>&2;
echo "          TGT.URL target URL, start with protocol" 1>&2;
echo "          FILEi   (directory containing) file(s) that the mapping is to be applied to" 1>&2;
echo "Internally, the replacement is done by sed -i.bak, so it will create a backup" 1>&2;
echo 1>&2;

SRC=`echo $1 | perl -pe 's/([\/])/\\\\\1/g;'`; shift
TGT=`echo $1 | perl -pe 's/([\/])/\\\\\1/g;'`; shift
for dir in $*; do 
	for file in `find $dir`; do
		if [ -f $file ]; then 
			sed -i.bak s/$SRC/$TGT/g $file;
		fi;
	done;
done

