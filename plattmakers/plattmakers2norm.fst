% this is a legacy implementation from early 2024, originally part of the NMK-corpus project

ALPHABET=[aäbcdefghijklmnoöpqrsßtuüvwxyz\-] ' ’:' [a-zöäü]:[A-ZÖÄÜ] \
		 [!"#\%&'()*,-./:;=?@\[\]\^\_{}~ ©°·–—’“„•…♀♂（）̩̯̃͡ːˑ0123456789aAáàăâåäÄãæɐɑbBcCćčçdDeEéÉèêěëęəɛfFgGɡhHiIíïɪjJkKlLłmMnNńŋoOóòôöÖøØœɔpPqQrRɾsSšŠßʃtTuUúůüÜʊvVwWxXyYʏzZžʒʔаАбБвВгГдђеёзЗийјклМноПрсСтТћуУФхцчьאדוימנןעצקרתいおし元改水濃縮還] % from json file

$SPACE$= ([\ ] | [\ ]:{}) (<>:[\ ] | <>:{})* <>:[\t] 
$DROP_SPACE$=(<>:[\ ] || $SPACE$)?


$C$=[bdfghjklmnprstvwxS]
$V$=[äaeiouöüAEIOUÖÄÜåœ] | au | ei | äu
	
% ä für nmk. a~e, vor r (Barch, Berch), n (annern, ännern) und im Demonstrativpronomen (dat, det)

$ORTH$= \
	% open syllable \
	å:a 	| \ % Ader
	Ä:ä 	| \
	Ä:e 	| \
	O:o 	| \ % Appelpannkoken
	å:o 	| \
	œ:ä 	| \ % äver 
	œ:ö 	| \ % allöverall 
	U:u 	| \
	Ü:ü 	| \
	Ü:y 	| \ % Etymologie
	\
	% closed syllable, short \
	a 		| \ % allöverall 
	e 		| \ % Ader
	e:ä 	| \
	i       | \ % Aalprick
	o 		| \
	u 		| \
	ö 		| \
	ü 		| \
	\
	% closed syllable, long \
	å:{aa}	| \ % Aalprick
	a:{aa}	| \ % asiaatsch
	å:{ah}	| \
	å:{oh} 	| \
	Ä:{ää} | \
	Ä:{äh} | \
	E:{ee} | \
	E:{eh} | \
	I:{ie} 	| \
	I:{ih}	| \
	O:{oo} 	| \
	U:{uh} 	| \ % Armkuhl
	U:{uu}	| \
	Ö:{öö}	| \
	Ü:{üü} 	| \
	Ü:{üh} | \
	œ:{oe} | \
	œ:{öh} | \
	\
	% diphthonge \
	{äu}:{oi} | \ % Ahoi
	{äu}:{eu} | \ % Deuker
	au 		| \ %Autodöör
	ei 		| \
	{ei}:{ai} | \ % Aserbaidschaan
	\
	b | \
	p | \
	p:{pp} | \
	\
	v 		| \
	f | \
	w | \
	d 		| \ % Ader
	t 		| \ % Atlas
	t:{th}	| \ % Äthiopien
	\
	k  		| \ % Armkuhl
	k:{ck}	| \
	g 		| \
	\
	x:{ch}	| \
	h |\
	j |\
	j:y | \ % Guyana
	\
	s 		| \ % Atlas
	s:ß 	| \
	S:{sch}	| \ % abelsch
	\
	l   	| \ % Armkuhl
	l:{ll}	 |\ 
	r  		| \ % Ader
	r:{rr} |\ 
	m  		| \ % Armkuhl
	m:{mm}	| \
	n:{nn}	| \
	n 		| \
	\
	':{’} 	| \
	\
	% verbundlaute \
	{ks}:x 	| \
	{ts}:z | \
	\
	% hiat und Lehnworte \
	u ':<> e | \ % hauen
	ei ':<> e | \ % eier
	\
	U:{ou} | \ % Fohrradtour
	[ou] ':<> a | \ % Februar, Fotoalbum, Elektroauto
	i ':<> [uo] | \ % Aluminium, Autoradio
	e ':<> [o] | \ % Video
	[ei] ':<> a <>:a? | \ % asiaatsch, Guinea
	u ':<> i | \ % Guinea
	{kwa}:{cua} % Ecuador

$NORMALIZE$= $DROP_SPACE$ ((<>:'| [^'])* || $ORTH$+) $DROP_SPACE$ (<>:[\ \	] (<>:.)*)?

% some postprocessing to faciliate matching
$NORM_V$=[aeiouäöüåœÄEIOUÖÜ]|au|äu|ei
$NORM_C$= [bdfghjklmnprstvwxS] \
		| b:{bb} \
		| d:{dd} \
		| f:{ff} \
		| g:{gg} \
		| j:{jj} \
		| k:{kk} \
		| l:{ll} \
		| m:{mm} \
		| n:{nn} \
		| p:{pp} \
		| r:{rr} \
		| s:{ss} \
		| t:{tt} \
		| v:{vv} \
		| x:{xx} % shouldn't happen \
		| S:{SS} % shouldn't happen 

$VALIDATE$=(! (v .* | .* (sk|sx|bb|dd|ff|gg|jj|kk|ll|mm|nn|pp|rr|ss|tt|vv|xx|SS) .*)) || \
                 $NORM_C$* $NORM_V$ ($NORM_C$+ $NORM_V$)* $NORM_C$*

$VALIDATE$ || $NORMALIZE$ || .* ([\(] .* [\)] .*)* .*