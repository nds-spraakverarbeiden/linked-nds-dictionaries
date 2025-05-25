% compile with -i to switch direction

% normalize to North Markian / North Low Saxon

ALPHABET=[	 !"&'+,-./:;=?\[\]~¡¦§«°´¶·¿˜„‡•‰›¤¢¥€01¹¼2²3³4⁴5⁵6⁶7⁷89aAªáâÂåÅäÄǟÃāĀbBᵇcCᶜÇdDeEᵉÈęēĒfFgGhHiIîīĪjJkKlLmMnNoOºöÖȪōŌœŒpPrRsSšßtT™uUüÜǖǕūŪvVwWxyYŸzZµ] [aeiouäöüœåÄEIOUÖÜ] [bdfghjklmnpqrstvwxS]

$SPACE$= ([\ ] | [\ ]:{}) (<>:[\ ] | <>:{})* <>:[\t] 

$DROP_SPACE$=(<>:[\ ] || $SPACE$)?

$WFAEL2NORM$=\
			\
			%%%%%%%%%%%%%%%%% \
			% single vowels % \
			%%%%%%%%%%%%%%%%% \
			\
			  a 		| a:A 		% af \
			| o:{å} 	| o:{Å} 	% Woªl-be-hålden (wallbehaulen), nmk. *wolbeholen \
			| e:{ä} 	| e:{Ä} 	% fer-äppelen, nmk. ferepeln \
			| Ä:{ǟ}	 				% wurm-ǟterig, Appel-kǟrne, ǟrnst; ?Snīde-kǟse \
			| å:{ā} 	| å:{Ā} 	% al-dāges \
			| å:{aa} 	| å:{Aa}	% Balderhaar \
			| e 		| e:E  		\
			| E:{iᵉ} 	| E:{Iᵉ} 	% Aske-kiᵉtel (Aschenkiedel), nmk. *aSkEtel; Iᵉgel; cf. Piᵉrd \
			| E:{ee} 				% nur in ON \
			| E:{eᵉ}				% ? Prō²we-preªdigeᵉ \
			| Ü:{üᵉ}	| Ü:{Üᵉ}	% Füᵉr-asse \
			| å:{uᵉ}	| å:{Uᵉ}	% Akker-fuᵉgel \
			| o:{uᵉ}	| å:{Uᵉ}	% Buᵉter-stükke \
			| U:{ūᵉ}				% Bāde-frūᵉ \
			| Ö:{ǖᵉ}				% Kāmer-dǖᵉre (hd?)\
			| <>:ᵉ  				% zwischen Konsonanten: In-bö:¹te-spliᵉtᵉken (Inbaitespliettkes), kiᵉsᵉlen \
			| e:ę 					% Boltse-męts \
			| E:{ē}		| E:{Ē}		% absolvēren \
			| {ei}:{ē} 				% buhēen, cf. juchay (Bornemann) \
			| (E:{ē}	| E:{Ē}	) (<>:[¹²³])? % an-er-bē¹den \
			| i 		| i:I 		\
			| I:{ī} 	| I:{Ī} 	% Abetīt, Anīs-brande-wīn\
			| Ä:{iᵉ} 	| Ä:{Iᵉ} 	% Iᵉge "Egge" \
			| o 		| o:O 		\
			| ö  		| ö:Ö 		\
			| (Ö:{ȫ} 	| Ö:{Ȫ}) (<>:[¹²³])?	% be-be-ȫ²gen \
			| (O:{ō} 	| O:{Ō}) (<>:[¹²³])?	% Adder-blō¹me, Akker-plō¹g \
			| u 		| u:U 		\
			| ü 		| ü:Ü 		\
			| Ü:{ǖ} 	| Ü:{Ǖ} 	% Akker-lǖde \
			| Ü:{üe} 				% Füer-be-grifken (OCR?)\
			| U:{ū} 	| U:{Ū} 	% Akker-būre \
			| E:{eª} 	| E:{Eª} 	% Advent-weªke, be-dreªgen \
			| Ä:{eª} 				% geªden "jäten" \
			| ä:{eª} r	| ä:{Eª} r 	% Arm-weªrk; ost-nmk. ä, west-nmk. e \
			| e:{e'ª} r 			% ale'ªrt \
			| e:{eª} 	| e:{Eª} 	% beªdel-arm, Bitter-keªrs \
			| å:{oª} 	| å:{Oª} 	% boªwen-an \
			| o:{oª} r 	| o:{Oª} r 	% Arm-koªrf \
			| œ:{öª} 	| œ:{Öª} 	% an-böªrnen, knöªkelig \
			| œ:{ȫª}	| œ:{Ȫª} 	% Ȫªwetken \
			| O:{ōª}  				% Dōªr \
			| e:{ēª} 				% flēªren \
			| å:{} 				%  Åld-jrs-dag \
			| Ö:{} (<>:[¹²³])? 	% bār-f¹tesk \
			\
			%%%%%%%%%%%%%%%%%%%%%%% \
			% apocopy and syncopy % \
			%%%%%%%%%%%%%%%%%%%%%%% \
			\
			| <>:e 					% K¹eken < kO-(e)"ken "kleine Kuh" \
			\
			%%%%%%%%%%%%%% \
			% diphthongs % \
			%%%%%%%%%%%%%% \
			\
			| {ei}:{ai} | {ei}:{Ai} % cf. Aigel \
			| {ei}:{äi} | {Äg}:{äi}	% Wē¹l-dräier, vgl. nmk. Hiatvelarisierung \
			| {ei}:{ǟi} | {eg}:{ǟi} % bǟien (bäggen), hd. _bähen_ "baden" \  
			| au 		| {au}:{Au} % tweie-hauen \
			| {Ug}:{au} | {ug}:{au}	% trauen "trauen" (hd?) \
			| äu 					% nur lat. \
			| {äu}:{ǟu} 			% nur lat. \
			| å:{e} 				% ? Temes-bǖdel (Tmsbǖdel) \
			| ei 		| {ei}:{Ei} % Würklikheid, acht-tein \
			| ei  		| {ei}:{Ey} % nur ON \
			| {ei}:{i} 			% ? Bēr-tite \
			| œ:{oa} 				% oawer-dō¹n, oawer-¹ē²ns (OCR error?)\
			| œ:{öª} 	| œ:{Öª} 	% an-böªrnen, Fīn-töªger \
			| Ö:{oi} 				% gloinig \
			| {Oj}:{oi} 			% knoien, cf. verweis auf nds. knōjen \
			| {äu}:{oi}				% Winkel-froilein (hd) \
			| {Ög}:{öi} 			% Möie, Bröie \
			| {äu}:{öi} 			% an-flöiten \
			\
			%%%%%%%%%%%%%% \
			% consonants % \
			%%%%%%%%%%%%%% \
			\
			| b 		| B 			\	
			| S:{sch} 	| S:{Sch} \
			| x:{ch} 	| x:{Ch}  \
			| k:{ck} 			% nur in ON \
			| d 		| d:D 	\
			| f  		| f:F \
			| g 		| g:G \
			| j 		| j:J 	\ 
			| k 		| k:K 	\
			| l 		| l:L   \
			| m 		| m:M 	\
			| n 		| n:N 	\
			| p 		| p:P 	\
			| r 		| r:R 	\
			| s 		| S:s 	\
			| S:{sk} 	| S:{Sk} \
			| S:s (mlnr) | S:S (mlnr) % slächten \
			| s:ß 		\
			| t 		| t:T 	\
			| v 						% Everswinkel \
			| v:b 						% bleben\
			| \- f:v 	| f:V 			% Ver-hängnüsse, Fuᵉgel-ver-kō²pen \
			| w 		| w:W 			% wurtelen \
			| v:w 						% allent-halwen \
			| {ks}:x 					% nur Eigennamen \
			| Ü:y 		| Ü:Y			% nur Eigennamen \
			| ü:y 						% nur Eigennamen \
			| {ei}:{ey} 				% nur Eigennamen \
			| {ts}:z 					% hd \
			\
			%%%%%%%%%% \
			% relics % \
			%%%%%%%%%% \
			\
			| <>:[ªᵇᶜ¹²³⁴⁵⁶⁷'!0-9\-] \

% keeping multi-word expressions
% $NORMALIZE$= \
	% $DROP_SPACE$ $WFAEL2NORM$+ ($SPACE$+ $WFAEL2NORM$+)* $DROP_SPACE$ (<>:[\	] (<>:.)*)?

% just the first word
% most of these are not MWEs, but contain artifacts, such as numberings
$NORMALIZE$= \
	$DROP_SPACE$ $WFAEL2NORM$+ $DROP_SPACE$? (<>:[\	\	] (<>:.)*)?

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
