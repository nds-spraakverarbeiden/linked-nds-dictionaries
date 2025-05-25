# Dialexicon Twents

- this is a Westphalian variety spoken in the Netherlands
- https://twentswoordenboek.nl/
- CC BY-NC-SA, Goaitsen van der Vliet 2025 (see https://twentswoordenboek.nl/), however, the content is technically somewhat protected, so it is not really certain whether this is meant to apply to the complete database content or just excerpts
- for the orthography, see [doc/Schriefwiezer.pdf](doc/Schriefwiezer.pdf)
- our release will not replicate the content, but only provide (deep) links to their lemmas
- build locally with `make`
- for building, these need to be locally mirrorred, though

> Note: We built an RDF index over the original URLs and linked it, but between Jan 2025 and May 2025, some re-numbering happened, so that the original URLs got re-allocated. Apparently, this happens whenever new content is added. As a result, the links are to be removed.

## Dev notes on the stand-alone version

TLDR: there is a static, versioned stand-alone version. However, this uses legacy software and cannot be directly processed.

sources available online

- https://goaitsen.nl/boek.php?pag=dial
- http://www.twentsetaalbank.nl/media/teksten/6.html
- binary files from https://www.dropbox.com/scl/fo/3dhys8dk3aec08hq9b7w5/ADoW0pUcDdTC1jqtmIPuEIY?rlkey=ivt68exxlzkrlvx5kjsvrojdx&e=1&st=sf4017dd&dl=0 (included here)
- `De eerste installatie` is installable under Ubuntu 22.04L with wine, but just expands to binary files similar to `De nieuwste versie`
- The file format of the word lists (`Twents.Lx1`, `Twents.Lx2`) does *not* seem to be the CFBF format (as hinted at by the `*.Dlx` extenson of the other files).
- Cannot be further processed without decompilation. 