import re,os,sys
import lxml.html as html
import lxml.etree as etree

""" resource-specific extractor script """

file=sys.argv[1]
url=sys.argv[2]

try:
	doc=html.parse(file)
	word=" ".join([ t.encode("latin-1").decode("utf-8").strip() for t in doc.xpath("//h3[@class='trefwoord'][1]")[0].itertext() ]).strip()
	word=" ".join(word.split(" "))
	word=re.sub(" of "," , ",word)
	pos=" ".join([ t.encode("latin-1").decode("utf-8").strip() for t in doc.xpath("//div[@class='soortFlexies'][1]")[0].itertext() ]).strip()
	pos="_".join(pos.split())

	if word!="":
		print(f"{word}\t{url}\t{pos}")
except Exception:
	pass

