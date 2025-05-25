# Linked Low German dictionaries

Low German (Low Saxon) online dictionaries as a linked lexical knowledge graph.

Licence to be confirmed.
# OntoLex-NDS

RDF conversion and linking of Low German dictionaries

## TLDR

Build `release/` with `make`, resp. `make update_release`. See [`release` directory](release/).
As a result, `release/` will contain RDF/TTL files and an HTML visualization of their interlinking.

Build `eval/` with `make`, resp., `make update_eval`. 
As a result, you can find a random sample of 50 links for WöWö, Reuter and Westphalian in [eval/woewoe-links.html](eval/woewoe-links.html). This file can be opened in standard Spreadsheet software and used for the manual evaluation of links, see [evaluation](#evaluation) below

## idea

- link WöWö RDF with other low german dictionaries
- use FSTs to normalize against Low German with apocope, no diphthongization (as North Markian, parts of North Low Saxon). This is a historical artifact, because the conversion was done in the context of a project on North Markian
- Note that Wörterbuchnetz contains links, but only between print editions (and, if available, their electronic edition *within Wörterbuchnetz*).
	- This includes links to the NdsWb, but this has not been digitized.

### challenges / research questions / limitations

- this has a practical motivation, to produce a machine- and human-readable multidialectal dictionary using LLOD technologies
- data modelling (RDF vocabulary)
	- how to link elements, these are not translation equivalents, but may represent the same Middle Low German lexeme in different dialects. Note that our entries can have different semantics and gramar, so these are not just formal variants
	- how to mark uncertainties: we only link based on formal agreement, so there is a level of uncertainty
- linking
	- we link on formal grounds, only, without semantics; at least, we need some evaluation

## sub tasks

build with `make`

- primary data
	- [x] [Wöwö-RDF](woewoe-rdf)
	- [x] [WöWö-Norm](woewoe-norm) for linking
- linked external data
	- [x] Plattmakers (links only), from nmk-corpus
	- [x] Sass (Links only)
	- [x] Platt-wb (Links only)
	- [x] Reuter (links only), from nmk-corpus
	- [x] Wörterbuchnetz, westfälisch (links only)
	- [x] Plautdietsch (https://ereimer.net/plautdietsch/pddefns.htm, CC BY-SA)
	- [DONT] wiktionary (no consistent orthography)
	- [x] Dialecticon Twents
	- [x] gronings (links only)
	- [x] Achterhoeks, e-wald.nl (links only)
	- [x] Drents (links only)
	- [x] MEW (links only, split for East Phalian and Markian) 
	- [x] Wisser (zur Eval) 
	- [x] recompile release/\*.html
- publication
	- [x] HTML visualization of interlinked dictionaries
	- [x] prep data for [evaluation](#evaluation)
	- [x] Levenshtein baseline

## evaluation

- [x] generate [eval/woewoe-links.html](eval/woewoe-links.html) with `make eval`
- [x] import this file in spreadsheet software. should contain 50 random WöWö words with four columns: 
	1. WöWö lemma (with link, but currently not resolving)
	2. WöWÖ sense 
	3. one Reuter lemma (with link)
	4. one Westphalian lemma (with link)
- [x] create new columns after Reuter and Westphalian columns and manually annotate for three categories 
	1. **y** match (definition roughly corresponds to WöWö definition, maybe one using different, but synonym words, or having a more specific meaning)
	2. **?** partial/possible match, if *either*
		- one word from a multi-word expression, e.g., WöWö "Block Speck" is a partial match for Reuter "Speck"
		- it seems possible that one meaning is derived from the other, e.g., Twents Oal (as a nickname with negative connotations) is a possible match with WöWö Ool 'eal', because it is somewhat transparently derived from the Twents word oal 'eal'
	3. **n** mismatch, if one is semantically unrelated to each other. Homophones should also fall into this category.
- [x] create a plot that put (bins of) confidence scores in relation with the match categories 
- [x] eval levenshtein baseline
- [ ] eval other varieties, eval levenshtein baseline
- [ ] eval against Wisser


## character mapping

- consonant mapping is mostly straight-forward. Except for some well-known digraphs (_sk_, _ck_, _tz_, _ch_) and trigraphs (_sch_), we just inspect every consonant for language variety and analyze a representative sample of forms to spot a systematic mapping
- vowel mapping is complicated because there is a lot of regional variation, postvocalic assimilations of consonants, etc., written with up to four characters (e.g., _eeuw_ in Dutch-based orthographies). We thus retrieve all sequences of non-consonantal characters and postvocalic lengthening signs (including Dutch _j_ and _w_, and German _h_) and inspect each sequence separately, e.g., 

		cut -f 1 mew.tsv  | sed -e s/'.'/'\L&'/g -e s/"[bcdfgjklmnpqrstvwxzß\s'\-]"/'\n'/g | egrep -v 'h.' | sort -u 

