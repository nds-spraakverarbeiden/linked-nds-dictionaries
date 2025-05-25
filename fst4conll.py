import sys,os,re

import sfst_transduce
from func_timeout import func_timeout, FunctionTimedOut

def conllize(annotations: list, prefix=""):
		""" convert the output of analyze() to CoNLL/TSV format 
			this should be a list of dicts
		"""
		result=[]
		if isinstance(annotations,list) or isinstance(annotations,set) or isinstance(annotations,tuple):
			for a in annotations:
				result+=conllize(a, prefix=prefix)
		elif isinstance(annotations,dict):
			for key,val in annotations.items():
				a=" ".join(str(key).strip().split())
				if a == "None" or a =="": a="_"
				result+=conllize(val, prefix=prefix+"\t"+a)
		else:
			a=" ".join(str(annotations).strip().split())
			if a in ["None","[]",""]: a="_"
			result=[prefix+"\t"+a]
		return result


class Analyzer:

	transducer=None
	minimization_regex=None


	def _disable_stderr(self):
		os.dup2 ( self.errnull_file.fileno(), self.old_stderr_fileno_undup )
		sys.stderr = self.errnull_file
		return self

	def _enable_stderr(self):
		sys.stderr = self.old_stderr
		os.dup2 ( self.old_stderr_fileno, self.old_stderr_fileno_undup )

	def __enter__(self):
		return self

	def __exit__(self, *_):
		sys.stderr = self.old_stderr
		os.dup2 ( self.old_stderr_fileno, self.old_stderr_fileno_undup )
		os.close ( self.old_stderr_fileno )
		self.errnull_file.close()

	def __init__(self, compiled_fst, minimization_regex=r"."):
		""" minimizaton regex is a regular expression to match symbols to be counted in minimization.
			this defaults to any character, but we can use it to count morpheme boundaries, etc. """

		self.minimization_regex=minimization_regex

		if isinstance(compiled_fst, sfst_transduce.Transducer):
			self.transducer=compiled_fst
		elif isinstance(compiled_fst,str):
			self.transducer=sfst_transduce.Transducer(compiled_fst)
		else:
			raise Exception(f"unsupported type: compiled_fst should be sfst_transduce.Transducer or string (file path), not {type(compiled_fst)}")
		
		self.errnull_file = open(os.devnull, 'w')
		self.old_stderr_fileno_undup    = sys.stderr.fileno()
		self.old_stderr_fileno = os.dup ( sys.stderr.fileno() )
		self.old_stderr = sys.stderr

	def analyze(self, text:str, normalization=True, timeout=None, debugFST=True, conll_out=False, generate=False, minimize=False, contrastive_features=[]):
		""" with normalization set, we attempt tokenization, lowercasing and punctuation stripping as fall-back strategies 
			with debugFST=False, suppress stderr stream from Transducer, recommended for production mode
			conll_out returns CoNLL/TSV
			if generate, we invert the transducer
			if minimize, we rank results by the number of matches against self.minimization_regex, this can be, for example, morph separators
			contrastive_features lists feature values that are to be distinguished. if none are given, we limit ourselves to the POS
		"""

		if debugFST==False:
			self._disable_stderr()
			result=self.analyze(text,normalization=normalization,debugFST=True,conll_out=conll_out, timeout=timeout, generate=generate)
			self._enable_stderr()
			return result

		# keep stderr
		result=[]
		words=[text]
		if normalization:
			words=text.split()
		for word in words:
			analyses=None
			variants=[word]
			if normalization:
				variants=[word,word.strip("'.,;:?!()[]/={}<>@"+'"'),word.lower(),word.lower().strip("'.,;:?!()[]/={}<>@"+'"')]
			for variant in variants:
				tmp_stderr=sys.stderr

				transducer_call=self.transducer.analyse
				if generate:
					transducer_call=self.transducer.generate

				results=[]
				if timeout==None:
					results=transducer_call(variant)
					results=list(results)
				else:
					try:
						results=func_timeout(timeout, transducer_call,args=[variant])
						results=list(results)
					except FunctionTimedOut:
						result=[]
				if results!=None and len(results)>0:
					analyses=list(results)
					break
			if analyses==None:
				analyses=["_"]
			result.append((word,analyses))
				
			if self.minimization_regex!=None:
				len2word2analyses={}
				# sys.stderr.write(str(result)+"\n")
				for word, analyses in result:
					for analysis in analyses:
						l=len(re.findall(self.minimization_regex,analysis))
						if not l in len2word2analyses: len2word2analyses[l]= {}
						if not word in len2word2analyses[l]: len2word2analyses[l][word]=[]
						if not analysis in len2word2analyses[l][word]: len2word2analyses[l][word].append(analysis)
				
				result=[]
				poses=[]
				for l in sorted(len2word2analyses):
					for w in len2word2analyses[l]:
						for a in len2word2analyses[l][w]:
							pos=a
							if " " in pos: pos=pos.split(" ")[0]
							if "/" in pos: pos=pos.split("/")[-1]
							if "+" in pos: pos=pos.split("+")[0]
							if "-" in pos: pos=pos.split("-")[0]
							if "." in pos: pos=pos.split(".")[0] # if enabled, we compare POS only, if disabled, we include features
							if contrastive_features!=None and len(contrastive_features)>0:
								for f in contrastive_features:
									if f in a.split(" ")[0].split("/")[-1].split("+")[0].split("-")[0].split("."):
										pos+="."+f
							if not pos in poses or not minimize:
								result.append((w,a))
								if not pos in poses:
									poses.append(pos)
				
			if conll_out:
				result= sorted([ c.strip() for c in conllize( [a for _,a in result ])])
		return result

if __name__ == "__main__":
	import argparse

	args=argparse.ArgumentParser(description="Apply compiled SFST transducers to textual or tabular data, return tabular output")
	args.add_argument("analyzer",type=str,help="compiled SFST analyzer, to be created with fst-compile or fst-compile-utf8 (file ending *.a)")
	args.add_argument("files",nargs="*", type=str, help="*.txt or *.tsv files, can contain XML markup and CoNLL-style comments, we evaluate everything before <TAB>")
	#args.add_argument("-tsv", "--tsv_format", action="store_true", help="if set, we require tabular input with one word per line. By default, this is automatically detected.")
	args.add_argument("-g", "--generate", action="store_true",help="if set, run the analyzer in the other direction")
	args.add_argument("-c", "--column", type=int, help="when reading TSV formats, read input from this column (zero-numbered); if set, this entails to run in TSV mode", default=None)
	args.add_argument("-m", "--minimize_output", action="store_true", help="for every possible part of speech, return the most minimalistic analysis", default=False)
	minimization_regex=r"[+/-]"
	args.add_argument("-mr","--minimization_regex", type=str, help=f"regex to identify the symbols to be counted in minimization, defaults to {minimization_regex}. If provided, results are ordered by increasing number of segments, which we interpret as plausibility. Entails -m. Note that this does not enable -m.", default=minimization_regex)
	contrastive_features=[	"Nom","Dat","Acc","Gen", 	# case
						  	"Pl",						# number (only plural)
						  	# "Masc","Neut","Fem",		# DON'T gender (because we get generic neutra, derived via verbs, otherwise)
						  	"1","2","3",				# number (pronouns, determiners and verbs)
						  	"Ind", "Prs", "Prt", "Inf", "Inf_to", "PPast", 	# verbal features
						  	"Ind", "Def", "Refl", "Int", "Rel"	# DET and PRON features
						  ]
	args.add_argument("-cf","--contrastive_features", type=str, nargs="*", help=f"if minimimize_output, use these as distinctive features, defaults to {contrastive_features}", default=contrastive_features)
	args=args.parse_args()

	with Analyzer(args.analyzer, minimization_regex=args.minimization_regex) as analyzer:

		if args.files==None or len(args.files)==0:
			args.files=[sys.stdin]
			sys.stderr.write("reading from stdin\n")
			sys.stderr.flush()

		for file in args.files:
			tsv_format=args.column
			input=file
			if isinstance(file,str):
				if file.split(".")[-1].lower() in ["conll", "conllu","tsv"]: tsv_format=True
				if file.split(".")[-1].lower() in ["xml","html","htm","txt","md"]: tsv_format=False
				input=open(file,"rt", errors="ignore")
				sys.stderr.write(f"reading {file}\n")
				sys.stderr.flush()

			for line in input:
					line=line.rstrip()
					if len(line)==0 or line.startswith("#"):
						print(line)
					else:
						if not(line.strip().startswith("#")) and len(line.split())>0:
							if tsv_format==None:
								if "\t" in line:
									tsv_format=True
									sys.stderr.write("detected TSV input, updating output style\n")
									sys.stderr.flush()
								elif " " in line:
									tsv_format=False
									sys.stderr.write("detected TXT input, updating output style\n")
									sys.stderr.flush()
						if "<" in line or not tsv_format:
							print("# "+line)
						line=re.sub(r"<[^>]*>","",line)
						line=line.split("<")[0]
						if ">" in line:
							line=line.split(">")[1]
						words=line
						cols=[]
						if tsv_format and args.column==None:
							args.column=0

						if tsv_format and len(line)>args.column:
							words=line.split("\t")
							if len(words)> args.column:
								words=words[args.column]
								cols=line.split("\t")
							else:
								words="_"
						
						words=words.split()
						for word in words:
							analyses=analyzer.analyze(word,conll_out=True,generate=args.generate,minimize=args.minimize_output, contrastive_features=args.contrastive_features)

							if analyses==None or len(analyses)==0:
								analyses=["_"]
							for analysis in analyses:
								print("\t".join(cols)+f"\t{word}\t{analysis}")
								cols="_"*len(cols)

						if(not tsv_format and len(words)>0):
							print()

