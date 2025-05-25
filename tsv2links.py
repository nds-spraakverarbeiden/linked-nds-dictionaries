import sys,os,re,argparse,json,traceback

#######
# aux #
#######

def beautify_url(string:str):
	if not ":" in string:
		string="http://"+string
	string="/".join(string.split("\\")).strip()
	string=re.sub(r"[#//]*$","",string)
	string=re.sub(r"([^:/#]/)[#/]+",r"\1",string)
	return string.strip()

'''
Jamiel Rahi
GPL 2019

A simple implementation of the Levenshtein distance algorithm.

In short: 
* We're comparing strings a and b 
* n = len(a), m = len(b)
* Construct an (n+1) by (m+1) matrix
* Elements (i,j) of the matrix satisfy the following :
	if min(i,j) == 0, lev(i,j) == max(i,j)
	else lev(i,j) = min of  
						lev(i-1,j) + 1, 
						lev(i,j-1) + 1, 
						lev(i-1,j-1) + (1 if a[i-1] != b[j-1])
* lev(n,m) is the levenshtein distance           
'''

import numpy as np

# ratio returns the levenshtein ratio instead of levenshtein distance
# print_matrix prints the matrix
# lowercase compares the strings as lowercase

def levenshtein(a,b,ratio=False,print_matrix=False,lowercase=False) :
	if type(a) != type('') :
		raise TypeError('First argument is not a string!')
	if type(b) != type('') :
		raise TypeError('Second argument is not a string!')
	if a == '' :
		return len(b)
	if b == '' :
		return len(a)
	if lowercase :
		a = a.lower()
		b = b.lower()

	n = len(a)
	m = len(b)
	lev = np.zeros((n+1,m+1))

	for i in range(0,n+1) :
		lev[i,0] = i 
	for i in range(0,m+1) :
		lev[0,i] = i

	for i in range(1,n+1) :
		for j in range(1,m+1) :
			insertion = lev[i-1,j] + 1
			deletion = lev[i,j-1] + 1
			substitution = lev[i-1,j-1] + (1 if a[i-1]!= b[j-1] else 0)
			lev[i,j] = min(insertion,deletion,substitution)

	if print_matrix :
		print(lev)

	if ratio :
		return (n+m-lev[n,m])/(n+m)
	else :
		return lev[n,m]

########
# init #
########

args=argparse.ArgumentParser(description=""" read TSV files as produced by woerterbuchnetz/Makefile, write OntoLex-compliant links to stdout""")
args.add_argument("file",type=str, nargs="?", help="TSV file to be read from, if omitted, read from stdin", default=None)
args.add_argument("-b", "--base_url", type=str, nargs="?", help="base URL of target document, defaults to file://FILE", default=None)
args.add_argument("-f","--form_col", type=int, default=0, help="SOURCE FORM column, defaults to 1st (0)")
args.add_argument("-u","--url_col", type=int, default=1, help="SOURCE URL column, defaults to 2nd (1)")
args.add_argument("-n","--norm_col", type=int, default=5, help="TARGET FORM (NORM) column, defaults to 6th (5)")
args.add_argument("-t","--tgt_col", type=int, default=6, help="TARGET URL (TARGET) column, defaults to 7th (6)")
args.add_argument("-c", "--include_confidence", action="store_true", help="include confidence score [1..0]")
args.add_argument("-all", "--return_all", action="store_true", help="return all candidate analyses (rather than just the most likely one)")
args.add_argument("-d","--debug", action="store_true",help="produce some debug info")
args.add_argument("-lt", "--language_tag", type=str, nargs="?", help="SOURCE language tag, e.g., nds for Low Saxon, wep for West Phalian in Germany", default=None)
args=args.parse_args()

if args.file==None:
	if args.base_url==None:
		raise Exception("when reading from stdin, --base_url is obligatory")
	else:
		args.base_url=beautify_url(args.base_url)
	sys.stderr.write(f"reading stdin into {args.base_url}\n")
	args.file=sys.stdin

#######
# run #
#######

file=args.file
base_url=args.base_url
if isinstance(file,str):
	if base_url==None:
		base_url="file://"+os.path.abspath(os.path.realpath(file))
	base_url=beautify_url(base_url)
	sys.stderr.write(f"reading {file} into {base_url}\n")
	file=open(file,"rt",errors="ignore")
sys.stderr.flush()

form2url2norm2tgt2conf={}
tgt2forms={}
form="_"
url="_"
for line in file:
		fields=line.split("\t")
		line=line.rstrip()
		if not line.strip().startswith("#"):
			try: 
				# these can stay the same
				if not fields[args.form_col].strip() in ["","_","*"]: form=fields[args.form_col].strip()
				if not fields[args.url_col].strip() in ["","_","*"]: url=fields[args.url_col].strip()
				
				# these must be on every line
				norm=fields[args.norm_col].strip()
				tgt=fields[args.tgt_col].strip()
				tgt="".join(tgt.split("\\")).strip() # FST artifact for SFST-reserved symbols
				if not tgt in ("","_"):
					if not form in form2url2norm2tgt2conf: form2url2norm2tgt2conf[form]={}
					if not url in form2url2norm2tgt2conf[form]: form2url2norm2tgt2conf[form][url]={}
					if not norm in form2url2norm2tgt2conf[form][url]: form2url2norm2tgt2conf[form][url][norm]={}
					if not tgt in form2url2norm2tgt2conf[form][url][norm]: form2url2norm2tgt2conf[form][url][norm][tgt]=None # to be calculated later
					if not tgt in tgt2forms: tgt2forms[tgt]=[form]
					if not form in tgt2forms[tgt]: tgt2forms[tgt].append(form)
			except Exception:
				if args.debug:
					traceback.print_exc()
					sys.stderr.write(f"while reading {line}\n")
					sys.stderr.flush()

# confidence is 1/number of possible links (bidirectional mean)
for form, url2norm2tgt2conf in form2url2norm2tgt2conf.items():
		for url, norm2tgt2conf in url2norm2tgt2conf.items():
			tgts=[]
			for tgt2conf in norm2tgt2conf.values():
				for tgt in tgt2conf:
					if not tgt in tgts:
						tgts.append(tgt)
			f2t=len(tgts)
			for norm, tgt2conf in norm2tgt2conf.items():
				for tgt in tgt2conf: 
					t2f=len(tgt2forms[tgt])
					conf=0
					try:
						conf=2*(1/f2t)*(1/t2f)/((1/f2t) + (1/t2f))
					except Exception:
						if args.debug:
							traceback.print_exc()
							sys.stderr.write(f"while reading \"{line}\"\n")
							sys.stderr.flush()
					form2url2norm2tgt2conf[form][url][norm][tgt]=conf

if not args.return_all:
		form2url2norm_tgt_conf={}
		for form in form2url2norm2tgt2conf:
			form2url2norm_tgt_conf[form]={}
			for url in form2url2norm2tgt2conf[form]:
				norm_tgt_conf=None
				for norm in form2url2norm2tgt2conf[form][url]:
					for tgt,conf in form2url2norm2tgt2conf[form][url][norm].items():
						if norm_tgt_conf == None \
						   or norm_tgt_conf[2] < conf \
						   or (norm_tgt_conf[2] == conf and \
						   		levenshtein(form,norm_tgt_conf[0]) > levenshtein(form,norm)) \
						   or (norm_tgt_conf[2] == conf and \
						   		levenshtein(form,norm_tgt_conf[0]) == levenshtein(form,norm) and len(tgt)<len(norm_tgt_conf[1])):
						   norm_tgt_conf=(norm,tgt,conf)
				form2url2norm2tgt2conf[form][url]={norm: {tgt: conf}}

# json.dump(form2url2norm2tgt2conf,sys.stdout)

sys.stdout.write(f"""
PREFIX ontolex: <http://www.w3.org/ns/lemon/ontolex#>
PREFIX vartrans: <http://www.w3.org/ns/lemon/vartrans#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX dc: <http://purl.org/dc/elements/1.1>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX lexinfo: <http://www.lexinfo.net/ontology/3.0/lexinfo#>\n\n""")

if args.include_confidence:
	sys.stdout.write(f"""<{base_url}> a <http://purl.org/dc/dcmitype/Dataset>;
		prov:wasGeneratedBy [ a prov:Activity; dc:description "SFST-based character mapping based on known sound correspondences with North Markian"@en ].\n\n""")

langtag=args.language_tag
links=0
if langtag ==None:
	langtag=""
langtag=langtag.strip()
if len(langtag)>0 and not langtag.startswith("@"):
	langtag="@"+langtag
for form in form2url2norm2tgt2conf:
	for url in form2url2norm2tgt2conf[form]:

		sys.stdout.write(f"""<{beautify_url(url)}> a ontolex:LexicalEntry;
			ontolex:canonicalForm [ a ontolex:Form; ontolex:writtenRep "{form}"{langtag} ] .\n """ )
		for norm in form2url2norm2tgt2conf[form][url]:
			for tgt,conf in form2url2norm2tgt2conf[form][url][norm].items():
				if args.include_confidence:
					links+=1
					link=f"<{base_url}#link_{beautify_url(url).split('/')[-1].split('#')[-1].split('=')[-1]}_{beautify_url(tgt).split('/')[-1].split('#')[-1].split('=')[-1]}_{links}>"
					sys.stdout.write(f"""{beautify_url(link)} a vartrans:LexicalRelation;
						vartrans:category lexinfo:geographicalVariant;
						dct:isPartOf <{base_url}>;
						vartrans:relates <{beautify_url(url)}>, <{beautify_url(tgt)}>;
						rdf:value "{conf}"^^xsd:float.\n""")
				else:
					sys.stdout.write(f"<{beautify_url(url)}> lexinfo:geographicalVariant <{beautify_url(tgt)}> .\n")
		sys.stdout.write("\n")


file.close()
