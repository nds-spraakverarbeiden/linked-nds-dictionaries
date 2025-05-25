% compile with -i to switch direction

% normalize to North Markian / North Low Saxon

ALPHABET=[!\#\%&*,./:;<>\_\|’…0123456789aAàâÂäÄbBḃcCdDeEėĖēĒfFgGğǧġhHiIjJkKlLmMnNoOöÖȫȪōŌpPqQrRsStTuUüÜvVwWxXyzZ\ \	\-] [aeiouäöüœåÄEIOUÖÜ] [bdfghjklmnpqrstvwxS]

$SPACE$= [\ ]

$WOEWOE2NORM$=\
			\
			%%%%%%%%%%%%%%%%% \
			% single vowels % \
			%%%%%%%%%%%%%%%%% \
			  a 		| a:A 		% achteran \
			| a:{à} 				% Vis-à-vis-Wogen \
			| a:â r 	| a:Â r 	% Zigârrendamp (Dehnung vor r) \
			| a:â l 	| a:Â r 	% överâll (Dehnung vor l) \
			| {ar}:{âe} | {ar}:{Âe}	% Âebeitsweek \
			| å:{â} r 				% Kârn \
			| å:{ââ} 			(<>:h)?	% lââtschen \
			| Ä:{ää} 			(<>:h)?	% Affäär \
			| e:{ä}					% afdämmen \
			| {är}:{er} | {är}:{Er} 	% Berg \
			| (Ä:ä 		| Ä:Ä) (<>:h)?					% Dağsläper, Bövertähn \
			| e 		| e:E 		% 			(closed syllable) \
			| (Ä:e 		| Ä:E) 	(<>:h)?	% eten gohn	(open syllable)\
			| (E:{ee} 	| E:{Ee}) (<>:h)?	% Afbeed \
			| e:{ė} 	| e:{Ė} 	% hėbben (Betonung?)\
			| (E:{ē}		| E:{Ē})	(<>:h)?	% Aftēker \
			| (E:{ēē}	| E:{Ēē}) (<>:h)?	% Afschēēd \
			| i 		| i:I 		\
			| I:{ie}	| I:{Ie} 	% iesern \
			| (å:{oo} 	| å:{Oo}) (<>:h)?	% Etoosch, översloon, Ool \
			| (O:{oo}	| O:{Oo}) (<>:h)?	% Book \
			| O:{oh} 	| O:{Oh} 	% Ohr \
			| (å:o 		| å:O)	(<>:h)?	% Etojenhuus, Oḃend, Johr, ohn (open syllable)\
			| o 		| o:O 		% op 				(closed syllable)\
			| (œ:ö 		| œ:Ö) (<>:h)?		% Ösel 				(open syllable) \
			| ö 		| ö:Ö 		% Öllern 			(closed syllable) \
			| (Ö:{öö}	| Ö:{Öö}) (<>:h)?	% Butendöör \
			| (Ö:{ȫ} 	| Ö:{Ȫ})	(<>:h)?	% ȫḃen "üben" \
			| (Ö:{ȫȫ} 	| Ö:{Ȫȫ}) (<>:h)?	\
			| (O:{ō}		| O:{Ō}) (<>:h)?	% Ōgenbru \
			| (O:{ōō}	| O:{Ōō}) (<>:h)?	% Ōōğappel \
			| o:{ō} l 	| o:{Ō} l 	% Ōlenhuus mit sekundärer Dehnung \
			| o:u ld 				% Trainsuldoot \
			| u 		| u:U 		% umhȫȫchlüchen 	(closed syllable) \
			| (U:u 		| U:U) (<>:h)? 		% Ulenspēgel		(open syllable) \
			| ü 		| ü:Ü 		% ünner 			(closed syllable)\
			| (Ü:ü 		| Ü:ü) (<>:h)?		% ünnerdükern 		(open syllable)\
			| ü:y 		| ü:Y 		% Ägypten \
			| Ü:y 		| Ü:Y 		% Syrien \
			\
			%%%%%%%%%%%%%% \
			% diphthongs % \
			%%%%%%%%%%%%%% \
			\
			| {ei}:{ai} 					% Maimoond \
			| {ei}:{ay}						% Lavay \
			| au 			| {au}:{Au} 	% Aukschōōn \
			| O:{au}						% ?Kauk \
			| ei 			| {ei}:{Ei}		% Boodmeister \
			| {Äg}:{eih} 					% dreihen \
			| {ei}:{ēi} 					% Sekērhēit \
			| {äu}:{eu}		| {äu}:{Eu}		% fleuten \
			| {äu}:{oi} 					% Koikârpen \
			| {Ög}:{oi’} 					% swoi’en \
			\
			%%%%%%%%%%%%%% \
			% consonants % \
			%%%%%%%%%%%%%% \
			\
			| b 		| b:B 	\
			| v:{ḃ} 			\
			| x:{ch} 	| x:{Ch} \
			| S:{sch} 	| S:{Sch} \
			| d 		| d:D 	\
			| f 		| f:F 	\
			| g 		| g:G 	\
			| g:{ğ} 			% Überlänge \
			| g:{ǧ} 			% Überlänge, graphische Variante \
			| g:{ġ} 			% Auslautverhärtung \
			| h 		| h:H 	\
			| j 		| j:J 	% Johr, aber cf. jiepern \
			| k:{ck} 			\
			| k 		| k:K 	\
			| l 		| l:L 	\
			| m 		| m:M 	\
			| n 		| n:N 	\
			| p 		| p:P 	\
			| {kw}:{qu} | {kw}:{Qu} % quabbig \
			| r 	 	| r:R 	\
			| s 		| s:S 	\
			| (S:s 		|  S:S) [lmnr] 	% Smietersch \
			| S:{sk} 	| S:{Sk}		% nur Lehnworte?\
			| t 		| t:T 	\
			| f:v 		| f:V 	% Vadder \
						| w:V 	% Variatschōōn \
			| v 				% sülvst, Wachstuuv \
			| w 		| w:W 	% Wannerârbeider \
			| {ts}:z 	| {ts}:Z % Zentroolroot \
			\
			%%%%%%%%%% \
			% relics % \
			%%%%%%%%%% \
			\
			<>:[!#\%&*,./:;<>_|’…\-]

% keeping multi-word expressions (future extension)
% $NORMALIZE$= \
	% $WOEWOE2NORM$+ ($SPACE$+ $WOEWOE2NORM$+)* (<>:[\	] (<>:.)*)?

% single-word entries, only
$NORMALIZE$= \
	$WOEWOE2NORM$+ (<>:[\	] (<>:.)*)?

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
		| S:{SS} % shouldn't happen \

$VALIDATE$=	(! (v .* | .* (sk|sx|bb|dd|ff|gg|jj|kk|ll|mm|nn|pp|rr|ss|tt|vv|xx|SS) .*)) || \
			$NORM_C$* $NORM_V$ ($NORM_C$+ $NORM_V$)* $NORM_C$*

% run it
$VALIDATE$ || $NORMALIZE$ || .* ([\(] .* [\)] .*)* .*



