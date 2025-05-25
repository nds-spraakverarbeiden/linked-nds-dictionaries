# Linked Low German dictionaries: RDF conversion and linking of Low German dictionaries

Low German (Low Saxon) online dictionaries as a linked lexical knowledge graph in OntoLex/RDF.
This has a practical motivation, to produce a machine- and human-readable multidialectal dictionary. At the moment, all existing dictionaries for Low German take an emphasized regional focus.

Licence to be confirmed.

When using, referring to or reporting this data, please cite ...

## TLDR

Build `release/` with `make`, resp. `make update_release`. See [`release` directory](release/).
As a result, `release/` will contain RDF/TTL files and an HTML visualization of their interlinking.

## Idea

- convert a dictionary of North Low Saxon (WöWö) to OntoLex/RDF
- link it with selected online dictionaries for Low German
	- because most of these are (explitly or implicitly) copyrighted, we only provide RDF indices *for WöWö lemmas*, i.e., only forms (and URLs) that have been linked with WöWö
	- lemmas in external dictionaries are identified by their *real URL*, to they do not resolve to RDF data, but to HTML.
- as linking cannot use the actual dictionaries, we only link by formal criteria
	- use FSTs to normalize against a selected variety with apocope and without diphthongization (here: North Markian)
	- This is a historical artifact, because the conversion was done in the context of a project on North Markian
- export as lexical knowledge graph in OntoLex (RDF)
- provide an HTML visualization for interactive inspection

Details are described in the accompanying paper.

> Note: Even though we process and convert Twents data, this has been excluded from the HTML release because of URL instability. It is still maintained in the knowledge graph as `release/twents-links.ttl`, but its URLs will point to the wrong lemma. 

To generate an up-to-date version of Twents data:

- crawl and build from scratch: `cd twents; make refresh`
- update `query.sparql` (seach for "Twents")
- delete `release/`
- run `make release`.

You can `make refresh` on the other dictionaries.