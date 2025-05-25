ALPHABET=[aäbcdeęfghijklmnoöœprsßtuüvwxyz'\-] ':[`’] [(),-./:;=?\[\]\_`´’0123456789aAäÄbBcCdDeEęfFgGhHiIjJkKlLmMnNoOöÖœpPqQrRsSßtTuUüÜvVwWxyzZ]

$SPACE$= ([\ ] | [\ ]:{}) (<>:[\ ] | <>:{})* <>:[\t] 
$DROP_SPACE$=(<>:[\ ] || $SPACE$)?

%%%%%%%%%%%%%%%%%%%
% syllabification %
%%%%%%%%%%%%%%%%%%%

$V$=[aeiouöäüEIOUÖÄÜåœ]|ei|au|äu
$C$=[bdfghjklmnprstvwxS]

% bootstrapped from begin of words
$ONSET$= <> \
	| b 	 \ % bootstrapped
	| bl 	 \ % bootstrapped
	| br 	 \ % bootstrapped
	| c 	 \ % bootstrapped
	| ch 	 \ % bootstrapped
	| chr 	 \ % bootstrapped
	| cl 	 \ % bootstrapped
	| cr 	 \ % bootstrapped
	| d 	 \ % bootstrapped
	| dr 	 \ % bootstrapped
	| dw 	 \ % bootstrapped
	| f 	 \ % bootstrapped
	| fl 	 \ % bootstrapped
	| fr 	 \ % bootstrapped
	| g 	 \ % bootstrapped
	| gl 	 \ % bootstrapped
	| gn 	 \ % bootstrapped
	| gr 	 \ % bootstrapped
	| h 	 \ % bootstrapped
	| j 	 \ % bootstrapped
	| k 	 \ % bootstrapped
	| kl 	 \ % bootstrapped
	| kn 	 \ % bootstrapped
	| kr 	 \ % bootstrapped
	| l 	 \ % bootstrapped
	| m 	 \ % bootstrapped
	| n 	 \ % bootstrapped
	| p 	 \ % bootstrapped
	| pl 	 \ % bootstrapped
	| pr 	 \ % bootstrapped
	| kw 	 \ 
	| r 	 \ % bootstrapped
	| s 	 \ % bootstrapped
	| sch 	 \ % bootstrapped
	| schm 	 \ % bootstrapped
	| schn 	 \ % bootstrapped
	| schr 	 \ % bootstrapped
	| sl 	 \ % bootstrapped
	| sm 	 \ % bootstrapped
	| sn 	 \ % bootstrapped
	| sp 	 \ % bootstrapped
	| spl 	 \ % bootstrapped
	| spr 	 \ % bootstrapped
	| st 	 \ % bootstrapped
	| str 	 \ % bootstrapped
	| sw 	 \ % bootstrapped
	| t 	 \ % bootstrapped
	| tr 	 \ % bootstrapped
	| tw 	 \ % bootstrapped
	| v 	 \ % bootstrapped
	| vl 	 \ % bootstrapped
	| w 	 \ % bootstrapped
	| wr 	 \ % bootstrapped
	| z 	 \ % bootstrapped
	| zw 	 \ % bootstrapped

% bootstrapped from end of words, optionally followed by s (unless last symbol was s)
$CODA$=<> \
	| b 	 \ % bootstrapped
	| bb 	 \ % bootstrapped
	| bbs 	 \ % bootstrapped
	| bs 	 \ % bootstrapped
	| ch 	 \ % bootstrapped
	| chs 	 \ % bootstrapped
	| chsch 	 \ % bootstrapped
	| chschs 	 \ % bootstrapped
	| chst 	 \ % bootstrapped
	| chsts 	 \ % bootstrapped
	| cht 	 \ % bootstrapped
	| chts 	 \ % bootstrapped
	| chtsch 	 \ % bootstrapped
	| chtschs 	 \ % bootstrapped
	| ck 	 \ % bootstrapped
	| cks 	 \ % bootstrapped
	| cksch 	 \ % bootstrapped
	| ckschs 	 \ % bootstrapped
	| ckt 	 \ % bootstrapped
	| ckts 	 \ % bootstrapped
	| ct 	 \ % bootstrapped
	| cts 	 \ % bootstrapped
	| d 	 \ % bootstrapped
	| dd 	 \ % bootstrapped
	| ddn 	 \ % bootstrapped
	| ddns 	 \ % bootstrapped
	| dds 	 \ % bootstrapped
	| ds 	 \ % bootstrapped
	| dsch 	 \ % bootstrapped
	| dschs 	 \ % bootstrapped
	| dt 	 \ % bootstrapped
	| dts 	 \ % bootstrapped
	| dtsch 	 \ % bootstrapped
	| dtschs 	 \ % bootstrapped
	| f 	 \ % bootstrapped
	| ff 	 \ % bootstrapped
	| ffs 	 \ % bootstrapped
	| fs 	 \ % bootstrapped
	| ft 	 \ % bootstrapped
	| fts 	 \ % bootstrapped
	| g 	 \ % bootstrapped
	| gd 	 \ % bootstrapped
	| gds 	 \ % bootstrapped
	| gg 	 \ % bootstrapped
	| ggs 	 \ % bootstrapped
	| ggt 	 \ % bootstrapped
	| ggts 	 \ % bootstrapped
	| gn 	 \ % bootstrapped
	| gns 	 \ % bootstrapped
	| gs 	 \ % bootstrapped
	| gsch 	 \ % bootstrapped
	| gschs 	 \ % bootstrapped
	| gst 	 \ % bootstrapped
	| gsts 	 \ % bootstrapped
	| gt 	 \ % bootstrapped
	| gts 	 \ % bootstrapped
	| h 	 \ % bootstrapped
	| hl 	 \ % bootstrapped
	| hls 	 \ % bootstrapped
	| hlsch 	 \ % bootstrapped
	| hlschs 	 \ % bootstrapped
	| hlt 	 \ % bootstrapped
	| hlts 	 \ % bootstrapped
	| hm 	 \ % bootstrapped
	| hms 	 \ % bootstrapped
	| hmsch 	 \ % bootstrapped
	| hmschs 	 \ % bootstrapped
	| hn 	 \ % bootstrapped
	| hns 	 \ % bootstrapped
	| hnst 	 \ % bootstrapped
	| hnsts 	 \ % bootstrapped
	| hnt 	 \ % bootstrapped
	| hnts 	 \ % bootstrapped
	| hr 	 \ % bootstrapped
	| hrs 	 \ % bootstrapped
	| hrsch 	 \ % bootstrapped
	| hrschs 	 \ % bootstrapped
	| hrt 	 \ % bootstrapped
	| hrts 	 \ % bootstrapped
	| hs 	 \ % bootstrapped
	| hst 	 \ % bootstrapped
	| hsts 	 \ % bootstrapped
	| ht 	 \ % bootstrapped
	| hts 	 \ % bootstrapped
	| k 	 \ % bootstrapped
	| kch 	 \ % bootstrapped
	| kchs 	 \ % bootstrapped
	| ks 	 \ % bootstrapped
	| ksch 	 \ % bootstrapped
	| kschs 	 \ % bootstrapped
	| kt 	 \ % bootstrapped
	| kts 	 \ % bootstrapped
	| l 	 \ % bootstrapped
	| ld 	 \ % bootstrapped
	| lds 	 \ % bootstrapped
	| lf 	 \ % bootstrapped
	| lfs 	 \ % bootstrapped
	| lft 	 \ % bootstrapped
	| lfts 	 \ % bootstrapped
	| lg 	 \ % bootstrapped
	| lgs 	 \ % bootstrapped
	| lj 	 \ % bootstrapped
	| ljs 	 \ % bootstrapped
	| lk 	 \ % bootstrapped
	| lks 	 \ % bootstrapped
	| ll 	 \ % bootstrapped
	| llg 	 \ % bootstrapped
	| llgs 	 \ % bootstrapped
	| llj 	 \ % bootstrapped
	| lljs 	 \ % bootstrapped
	| lln 	 \ % bootstrapped
	| llns 	 \ % bootstrapped
	| lls 	 \ % bootstrapped
	| llsch 	 \ % bootstrapped
	| llschs 	 \ % bootstrapped
	| lm 	 \ % bootstrapped
	| lms 	 \ % bootstrapped
	| ln 	 \ % bootstrapped
	| lns 	 \ % bootstrapped
	| lp 	 \ % bootstrapped
	| lps 	 \ % bootstrapped
	| ls 	 \ % bootstrapped
	| lsch 	 \ % bootstrapped
	| lschs 	 \ % bootstrapped
	| lst 	 \ % bootstrapped
	| lsts 	 \ % bootstrapped
	| lt 	 \ % bootstrapped
	| lts 	 \ % bootstrapped
	| lw 	 \ % bootstrapped
	| lws 	 \ % bootstrapped
	| lwst 	 \ % bootstrapped
	| lwsts 	 \ % bootstrapped
	| lz 	 \ % bootstrapped
	| lzs 	 \ % bootstrapped
	| m 	 \ % bootstrapped
	| md 	 \ % bootstrapped
	| mds 	 \ % bootstrapped
	| mm 	 \ % bootstrapped
	| mms 	 \ % bootstrapped
	| mp 	 \ % bootstrapped
	| mps 	 \ % bootstrapped
	| mpsch 	 \ % bootstrapped
	| mpschs 	 \ % bootstrapped
	| ms 	 \ % bootstrapped
	| msch 	 \ % bootstrapped
	| mschs 	 \ % bootstrapped
	| mt 	 \ % bootstrapped
	| mts 	 \ % bootstrapped
	| n 	 \ % bootstrapped
	| nd 	 \ % bootstrapped
	| nds 	 \ % bootstrapped
	| ndsch 	 \ % bootstrapped
	| ndschs 	 \ % bootstrapped
	| ndt 	 \ % bootstrapped
	| ndts 	 \ % bootstrapped
	| nft 	 \ % bootstrapped
	| nfts 	 \ % bootstrapped
	| ng 	 \ % bootstrapped
	| ngs 	 \ % bootstrapped
	| ngsch 	 \ % bootstrapped
	| ngschs 	 \ % bootstrapped
	| ngst 	 \ % bootstrapped
	| ngsts 	 \ % bootstrapped
	| nk 	 \ % bootstrapped
	| nks 	 \ % bootstrapped
	| nksch 	 \ % bootstrapped
	| nkschs 	 \ % bootstrapped
	| nkt 	 \ % bootstrapped
	| nkts 	 \ % bootstrapped
	| nn 	 \ % bootstrapped
	| nns 	 \ % bootstrapped
	| nnst 	 \ % bootstrapped
	| nnsts 	 \ % bootstrapped
	| nnt 	 \ % bootstrapped
	| nnts 	 \ % bootstrapped
	| ns 	 \ % bootstrapped
	| nsch 	 \ % bootstrapped
	| nschs 	 \ % bootstrapped
	| nsk 	 \ % bootstrapped
	| nsks 	 \ % bootstrapped
	| nst 	 \ % bootstrapped
	| nsts 	 \ % bootstrapped
	| nt 	 \ % bootstrapped
	| nts 	 \ % bootstrapped
	| nz 	 \ % bootstrapped
	| nzs 	 \ % bootstrapped
	| p 	 \ % bootstrapped
	| pf 	 \ % bootstrapped
	| pfs 	 \ % bootstrapped
	| ph 	 \ % bootstrapped
	| phs 	 \ % bootstrapped
	| phsch 	 \ % bootstrapped
	| phschs 	 \ % bootstrapped
	| pp 	 \ % bootstrapped
	| pps 	 \ % bootstrapped
	| ppv 	 \ % bootstrapped
	| ppvs 	 \ % bootstrapped
	| ps 	 \ % bootstrapped
	| psch 	 \ % bootstrapped
	| pschs 	 \ % bootstrapped
	| pt 	 \ % bootstrapped
	| pts 	 \ % bootstrapped
	| r 	 \ % bootstrapped
	| rb 	 \ % bootstrapped
	| rbs 	 \ % bootstrapped
	| rch 	 \ % bootstrapped
	| rchs 	 \ % bootstrapped
	| rd 	 \ % bootstrapped
	| rds 	 \ % bootstrapped
	| rdsch 	 \ % bootstrapped
	| rdschs 	 \ % bootstrapped
	| rf 	 \ % bootstrapped
	| rfs 	 \ % bootstrapped
	| rg 	 \ % bootstrapped
	| rgs 	 \ % bootstrapped
	| rgsch 	 \ % bootstrapped
	| rgschs 	 \ % bootstrapped
	| rk 	 \ % bootstrapped
	| rks 	 \ % bootstrapped
	| rksch 	 \ % bootstrapped
	| rkschs 	 \ % bootstrapped
	| rkt 	 \ % bootstrapped
	| rkts 	 \ % bootstrapped
	| rl 	 \ % bootstrapped
	| rls 	 \ % bootstrapped
	| rm 	 \ % bootstrapped
	| rms 	 \ % bootstrapped
	| rn 	 \ % bootstrapped
	| rns 	 \ % bootstrapped
	| rnst 	 \ % bootstrapped
	| rnsts 	 \ % bootstrapped
	| rnt 	 \ % bootstrapped
	| rnts 	 \ % bootstrapped
	| rp 	 \ % bootstrapped
	| rps 	 \ % bootstrapped
	| rr 	 \ % bootstrapped
	| rrn 	 \ % bootstrapped
	| rrns 	 \ % bootstrapped
	| rrs 	 \ % bootstrapped
	| rs 	 \ % bootstrapped
	| rsch 	 \ % bootstrapped
	| rschs 	 \ % bootstrapped
	| rß 	 \ % bootstrapped
	| rßs 	 \ % bootstrapped
	| rst 	 \ % bootstrapped
	| rsts 	 \ % bootstrapped
	| rt 	 \ % bootstrapped
	| rth 	 \ % bootstrapped
	| rths 	 \ % bootstrapped
	| rts 	 \ % bootstrapped
	| rv 	 \ % bootstrapped
	| rvs 	 \ % bootstrapped
	| rw 	 \ % bootstrapped
	| rws 	 \ % bootstrapped
	| rwst 	 \ % bootstrapped
	| rwsts 	 \ % bootstrapped
	| rwt 	 \ % bootstrapped
	| rwts 	 \ % bootstrapped
	| rz 	 \ % bootstrapped
	| rzs 	 \ % bootstrapped
	| s 	 \ % bootstrapped
	| sch 	 \ % bootstrapped
	| schs 	 \ % bootstrapped
	| sk 	 \ % bootstrapped
	| sks 	 \ % bootstrapped
	| sm 	 \ % bootstrapped
	| sms 	 \ % bootstrapped
	| sp 	 \ % bootstrapped
	| sps 	 \ % bootstrapped
	| ss 	 \ % bootstrapped
	| ß 	 \ % bootstrapped
	| ßs 	 \ % bootstrapped
	| ßsch 	 \ % bootstrapped
	| ßschs 	 \ % bootstrapped
	| ßt 	 \ % bootstrapped
	| ßts 	 \ % bootstrapped
	| st 	 \ % bootstrapped
	| sts 	 \ % bootstrapped
	| t 	 \ % bootstrapped
	| th 	 \ % bootstrapped
	| ths 	 \ % bootstrapped
	| ts 	 \ % bootstrapped
	| tsch 	 \ % bootstrapped
	| tschs 	 \ % bootstrapped
	| tst 	 \ % bootstrapped
	| tsts 	 \ % bootstrapped
	| tt 	 \ % bootstrapped
	| tts 	 \ % bootstrapped
	| ttsch 	 \ % bootstrapped
	| ttschs 	 \ % bootstrapped
	| tz 	 \ % bootstrapped
	| tzs 	 \ % bootstrapped
	| tzsch 	 \ % bootstrapped
	| tzschs 	 \ % bootstrapped
	| tzt 	 \ % bootstrapped
	| tzts 	 \ % bootstrapped
	| v 	 \ % bootstrapped
	| vs 	 \ % bootstrapped
	| w 	 \ % bootstrapped
	| wk 	 \ % bootstrapped
	| wks 	 \ % bootstrapped
	| ws 	 \ % bootstrapped
	| wsch 	 \ % bootstrapped
	| wschs 	 \ % bootstrapped
	| wst 	 \ % bootstrapped
	| wsts 	 \ % bootstrapped
	| wt 	 \ % bootstrapped
	| wts 	 \ % bootstrapped
	| ww 	 \ % bootstrapped
	| wws 	 \ % bootstrapped
	| wwt 	 \ % bootstrapped
	| wwts 	 \ % bootstrapped
	| x 	 \ % bootstrapped
	| xs 	 \ % bootstrapped
	| xt 	 \ % bootstrapped
	| xts 	 \ % bootstrapped
	| z 	 \ % bootstrapped
	| zs 	 \ % bootstrapped

% not perfect, fails for 98 from 10893
$BREAK$= 	\
	$CODA$ ':<> $ONSET$ \
	 | ':<> % hiat insertion: TODO: should be limited to cases with non-identical vowels ... but we don't see vowels out of $BREAK$

%%%%%%%%%%%
% mapping %
%%%%%%%%%%%

$SHORT_OPEN_VOWEL$ = å:a 	\ % Addelwater
				   | Ä:ä 	\ % blädern, Brummkäwer 
				   | œ:ä 	\ % doräwer
				   | e  	\  % Adebor
				   | E:e 	\ % Abendeten
				   | I:i 	\ % afbiten
				   | i 		\ % Löwenbänniger, Brüdijam
				   | O:o 	\ % aflopen
				   | å:o 	\ % Fomilienuptritt
				   | o 	 	\ % spijoniren
				   | œ:ö 	\ % militörisch
				   | ö 		\ % Achtgröschenstück
				   | Ö:ö 	\ % afstöten
				   | œ 		\ % slœkerig
				   | U:u 	\ % afbruken
				   | Ü:ü 	\ % afrümen
				   | I:y 	\ % Zyrop
				   | ü:y 	\ % Hypochondri

$SHORT_VOWEL_CLOSED$ = a 	\ % Adjutant
					 | e:ä 	\ % anstännig  
					 | e 	\ % aasen, Abendbrod
					 | i 	\ % achtig
					 | I:i 	\ % Maschin, driwen
					 | O:o 	\ % Abendbrod
					 | å:o 	\ % Adebor
					 | o 	\ % anglotzen
					 | ö 	\ % Afgötteri
					 | Ö:ö 	\ % afrömen
					 | œ 	\ % slœkerig
					 | U:u 	\  % abslut
					 | u 	\ % achteihnhunnert
					 | ü 	\ % Abendsünn
					 | Ü:ü 	\ % balkendüster
					 | ü:y 	\ % Gymnast

$LONG_VOWEL$ = å:{aa} (<>:h)?	\ % Utsaat, Aal
			 | å:{ah} 			\ % betahlen, Ahrbor
			 | œ:{äh}			\ % Börgersähn
			 | Ä:{äh}			\ % tähmen, Tähn
			 | O:{au} (<>:h)? 	\ % Abendrauh, alltau
			 | au 				\ % Austköst
			 | Ö:{äu} (<>:h)? 	\ % abspäulen, äwermäudig, befäuhlen
			 | äu (<>:h)?		\ % kein Beispiel, doch in analogie zu au
			 | E:{eh}			\ % aflehnen (no ee)
			 | ei (<>:h)?	 	\ % teihn
			 | E:{ei} (<>:h)? 	\ % achterdeil, Häuhnerveih
			 | I:{ie} (<>:h)?	\ % afrieden
			 | E:{ih} 			\ % aflihren (h-Schreibung simuliert dem hochdeutschen)
			 | å:{oh} 			\ % anfohren
			 | O:{oh}			\ % Arwtstrohhümpel
			 | Ö:{öh} 			\ % Aflöhnung, flöhhäuden
			 | œ:{öh}			\ % drütteihnjöhrig
			 | U:{uh}			\ % afpuhlen
			 | Ü:{üh}			\ % Frühjohrstid

$VOWEL_BEFORE_R$ = E:i (<>:[eh])?	\ % Abendstirn, belihren
				 | O:u (<>:[uh])?	\ % antwurten, Durn, Eselsuhr, ?Gehursam
				 | Ö:ü (<>:[üh])?	\ % anhüren, äwerführen
				 | œ:ö 				\ % vörtrecken

$CONS$ = b (<>:b)? 	\
	   | x:{ch}		\
	   | S:{sch}		\
	   | S:s [lmnrw] \
	   | S:{sk}		\
	   | k:{ck} 	\
	   | k:c 		\ % curjos, Balcan
	   | d (<>:[dt])?	\ % Goldsmidt, Auslautverhärtung
	   | f (<>:f)? 	\
	   | f:{ph} \
	   | g (<>:g)? 	\
	   | h \
	   | j \
	   | (<>:[ck])? k \
	   | l (<>:l)? \
	   | m (<>:m)? \
	   | n (<>:n)? \
	   | p (<>:p)? \
	   | r (<>:r)? \
	   | s (<>:s)? \
	   | s:ß \ % wirkt kürzend, das ist aber schon mitgenommen, da ß eingangs gesplittet wird
	   | t (<>:[dth])? \
	   | f:v \ % vörtrecken 
	   | v 	 \ % zevil, Antrittsvesit, Avvekat 
	   | w 	 \ % Wunnerwarken
	   | v:w (<>:w)? \ % wölwen, woräwer, Wustkorw, Zuckeldraww
	   | {ks}:x \
	   | (<>:t)? {ts}:z 

%%%%%%%%%%%%%%%%%%
% transformation %
%%%%%%%%%%%%%%%%%%

$SYLLABIFY_ONE_WORD$= ( $C$* | ['] )* ($V$ ( $BREAK$  $V$)* (['] | $C$)*)? 

$SYLLABIFY$=$SYLLABIFY_ONE_WORD$ ( [\-] $SYLLABIFY_ONE_WORD$)*

$INVALID_SEQ$= 	$V$ h | \
				th | rh | ph | \
				s x | s'x | k'h | kh |\
				a'a | a'i | a'o | a'u | a'E | a'I | a'O | a'U | a'Ö | a'Ü | a'Ä | a'å | a'œ | a'ä | a'ö | a'ü | \
				e'a | e'i | e'o | e'u | e'E | e'I | e'O | e'U | e'Ö | e'Ü | e'Ä | e'å | e'œ | e'ä | e'ö | e'ü | \ % for e, this is possible, because of be-
				i'a | i'i | i'o | i'u | i'E | i'I | i'O | i'U | i'Ö | i'Ü | i'Ä | i'å | i'œ | i'ä | i'ö | i'ü | \
				o'a | o'i | o'o | o'u | o'E | o'I | o'O | o'U | o'Ö | o'Ü | o'Ä | o'å | o'œ | o'ä | o'ö | o'ü | \
				u'a | u'i | u'o | u'u | u'E | u'I | u'O | u'U | u'Ö | u'Ü | u'Ä | u'å | u'œ | u'ä | u'ö | u'ü | \
				ö'a | ö'i | ö'o | ö'u | ö'E | ö'I | ö'O | ö'U | ö'Ö | ö'Ü | ö'Ä | ö'å | ö'œ | ö'ä | ö'ö | ö'ü | \
				ü'a | ü'i | ü'o | ü'u | ü'E | ü'I | ü'O | ü'U | ü'Ö | ü'Ü | ü'Ä | ü'å | ü'œ | ü'ä | ü'ö | ü'ü | \
				ä' 
$VALIDATOR$= \
	!( .* $INVALID_SEQ$ .*) 

$MAPPING$=\
	($CONS$*  \  
	 ($SHORT_OPEN_VOWEL$ | \
	  $VOWEL_BEFORE_R$ r (<>:r)? $CONS$* | \
	  $SHORT_VOWEL_CLOSED$ $CONS$+ |\
	  $LONG_VOWEL$ $CONS$*)?) \
	( ['\-] $CONS$* \
		(\ %  
		 $SHORT_OPEN_VOWEL$ | \
		 $VOWEL_BEFORE_R$ r (<>:r)? $CONS$* | \
		 $SHORT_VOWEL_CLOSED$ $CONS$+ |\
		 $LONG_VOWEL$ $CONS$*)?)*

#include "desyllabify.fst"

$LEMMA$=\
	$DESYLLABIFY$ || \
	$VALIDATOR$ || \
	$MAPPING$ || \
	$SYLLABIFY$ || \
	[a-pr-zöäüœåæ\-']* || \
	(a:A|ä:Ä|b:B|c:C|d:D|e:E|ę:Ę|f:F|g:G|h:H|i:I|j:J|k:K|l:L|m:M|n:N|œ:Œ|o:O|ö:Ö|p:P|r:R|s:S|ß|t:T|u:U|ü:Ü|v:V|w:W|x:X|y:Y|z:Z|{kw}:{qu}|{kw}:{qw}|{ks}:x|{kk}:{ck}|{kw}:{Qu}|ss:{ß}|t:{th}|$C$|$V$|'|.)*

% validation already integrated
$DROP_SPACE$ ((<>:' | .)* || $LEMMA$ $DROP_SPACE$) (<>:[\ \	] (<>:.)*)?



