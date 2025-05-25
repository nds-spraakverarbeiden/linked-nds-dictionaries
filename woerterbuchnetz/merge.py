import json,re,sys,os,argparse
from lxml import etree
from io import StringIO
from pprint import pprint

args=argparse.ArgumentParser(description="""read crawler and API output and write a consolidated JSON file to stdout""")
args.add_argument("lemmas", type=str, help="JSON file produced by https://api.woerterbuchnetz.de/open-api/dictionaries/WWB/lemmata/* (or analoguous)")
args.add_argument("html", type=str,nargs="+",help="HTML files produced by crawling lemma ids; each file can contain multiple lemmas; note that these must be XML-valid/linted before, e.g., using xmllint --html --xmlout --recover")
args=args.parse_args()

with open(args.lemmas, "rt", errors="ignore") as input:
	sys.stderr.write(f"reading from {args.lemmas}\n")
	lemma_export=json.load(input)
	lemmas={}
	for l in lemma_export["result_set"]:
		lemmas[l["wbnetzid"]]=l

result=[]

for file in args.html:
	sys.stderr.write(f"reading from {file}\n")
	sys.stderr.flush()

	root=etree.parse(file)
	for article in root.findall("//div[@class='article-container']"):
		lexical_entry=article.attrib["id"].split("-")[-1]
		#print(etree.tostring(article,pretty_print=True).decode("utf-8"))
		if lexical_entry in lemmas:
			lemmas[lexical_entry]["spans"]=[]
			last_cl=None
			for span in article.findall(".//span"):
				if "id" in span.attrib and span.attrib["id"].startswith("wwb-textid-"):
					cl="_"
					if "class" in span.attrib: 
						cl=span.attrib["class"]
					cl=" ".join([c for c in cl.split() if not c in ["wwb-text-word"]])
					text=span.text
					if text!=None and not text.strip()=="":
						if cl==last_cl:
							#lemmas[lexical_entry]["spans"].append(etree.tostring(span,pretty_print=True).decode("utf-8"))
							last_tuple=lemmas[lexical_entry]["spans"][-1]
							new_tuple=(last_tuple[0]," ".join((last_tuple[1]+" "+text).strip().split()))
							lemmas[lexical_entry]["spans"][-1]=new_tuple
						else:
							lemmas[lexical_entry]["spans"].append((cl,text))
							last_cl=cl
			result.append(lemmas[lexical_entry])
#		pprint(lemmas[lexical_entry])
#		print()


json.dump(result,sys.stdout)



