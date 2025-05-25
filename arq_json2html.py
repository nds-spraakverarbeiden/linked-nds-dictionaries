import json,sys,os,re
import lxml.html as etree

""" call with a JSON file produced by arq, write HTML to stdout """

file=sys.argv[1]

# todo: add metadata here
output=etree.fromstring("<html><body><div id='arq_results'><table>")
	
with open(file,"rt",errors="ignore") as input:
	results=json.load(input)
	
	for table in output.xpath("//div[@id='arq_results']/table[1]"):
		row=etree.fromstring("<tr><th>"+"</th><th>".join(results["head"]["vars"]))
		table.append(row)
		sortkey_rows=[]
		for binding in results["results"]["bindings"]:
			row="<tr><td>"
			sortkey=""
			for var in results["head"]["vars"]:
				if var in binding:
					val=binding[var]["value"]
					if "<" in val:
						links=[]
						for chunk in val.split(">"):
							chunk=chunk.strip()
							if len(chunk)>0:
								url=chunk.split("<")[-1]
								lemma=chunk.split('@')[0]#
								lemma="".join(lemma.split('"')).strip()
								sortkey+=" ".join(re.sub(r"[(][^)]*[)]","",lemma).split())+" "
								link=f'<a href="{url}">{lemma}</a>'
								if "[" in chunk:
									confidence=chunk.split("[")[-1].split("]")[0]
									
									# this is a bit of a hack for rounding with regular expressions
									confidence=re.sub(r"([1-9])0[5-9].*",r"\1 1", confidence)
									confidence=re.sub(r"([1-9])1[5-9].*",r"\1 2", confidence)
									confidence=re.sub(r"([1-9])2[5-9].*",r"\1 3", confidence)
									confidence=re.sub(r"([1-9])3[5-9].*",r"\1 4", confidence)
									confidence=re.sub(r"([1-9])4[5-9].*",r"\1 5", confidence)
									confidence=re.sub(r"([1-9])5[5-9].*",r"\1 6", confidence)
									confidence=re.sub(r"([1-9])6[5-9].*",r"\1 7", confidence)
									confidence=re.sub(r"([1-9])7[5-9].*",r"\1 8", confidence)
									confidence=re.sub(r"([1-9])8[5-9].*",r"\1 9", confidence)
									confidence="".join(confidence.split())

									confidence=re.sub(r"([1-9][0-9]).*",r"\1", confidence)								
									link+=f' [{confidence}]'
								links.append(link)
						val="<br/>".join(links)
					row+=val
				row+="</td><td>"
			row+="</tr>"
			sortkey_rows.append((sortkey,row))
		for _,row in sorted(set(sortkey_rows)):
			row=etree.fromstring(row)
			table.append(row)

	print(etree.tostring(output).decode("utf-8"))