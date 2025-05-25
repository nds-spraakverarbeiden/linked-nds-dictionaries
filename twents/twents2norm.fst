% normalize to North Markian / North Low Saxon

% preliminary
ALPHABET=[&'()*,\-./:\[\]|~123aAäbBcCdDeEèëfFgGhHiIïjJkKlLmMnNoOöpPQrRsStTuUùvVwWXYzZ] \
		 [aeiouäöüœåÄEIOUÖÜ] [bdfghjklmnpqrstvwxS]

$SPACE$= ([\ ] | [\ ]:{}) (<>:[\ ] | <>:{})* <>:[\t] 

$DROP_SPACE$=(<>:[\ ] || $SPACE$)?

% incomplete
% '-aAäbBcdeèëfgGhiïjJklmnoöprstuùvwz
% check full alphabet

$WFAEL2NORM$=\
			\
			%%%%%%%%%%%%%%%%% \
			% single vowels % \
			%%%%%%%%%%%%%%%%% \
			\
			  a 		| a:A 		% achtig \
			| å:{aa}	| å:{Aa} 	% aadler \
			| a:{aa} r	| a:{Aa} r 	% aarbeidn \
			| ä:{aa} nd | ä:{Aa} nd % aandern \
			| ä:{aa} r 	| ä:{Aa} r 	% aargernis, vgl. nmk. Brechnung \
			| a:{aa} n 	| a:{Aa} n 	% aanker \
			| e:ä 		| e:Ä 		% beständig \
			| ä r 		| ä:{Ä} r 	% bärksken \
			| Ä:ä 		| Ä:Ä 		% blädken \
			| e 		| e:E 		% aadler \
			| Ä:e 		| Ä:E 		% aanderweggens, nmk. Dehnung \
			| E:e 		| E:E 		% achterbene \
			| E:{ee} 	| E:{Ee} 	% aarmmeester \
			| ei 		| Ei 		% aarmmeister \
			| ä:e r 	| ä:E r 	% aarmhertig, nmk. Brechnung \
			| I:{ie} 	| I:{Ie}	% aaitied \
			| U:{oe} 	| U:{Oe} 	% abbesloet \
			| ü:{eu} n	| ü:{Eu} n	% aavngeunstigheid \
			| œ:{eu} 	| œ:{Eu} 	% achteranveurn (wohl nicht fÖren "führen") \
			| Ö:{eu} 	| Ö:{Eu} 	% ? aarmeudig \
			| ä:{ea} r 	| ä:{Ea} r	% Achterbearg \
			| Ä:{ea} 	| Ä:{Ea} 	% almealig \
			| e:{ea} 	| e:{Ea} 	% adveant, andeankn (Dehnung) \
			| e:è 					% appèlplas \
			| e:ë 		| Ö:{ëu}	% beëugn, beërdigen\
			| ei 		| Ei 		% aarbeidn \
			| i  		| i:I 		% aaklig \
			| i:ï 					% bleuïgheid \
			| o 		| o:O 		% aalton \
			| O:{oo} 	| O:{Oo} 	% achteloos \
			| u:{oo} nd	| u:{Oo} nd	% aankergroond, achthoonderd, nmk. Kürzung \
			| å:{oa} 	| å:{Oa} 	% advokoat \
			| U:{oe} 	| U:{Oe} 	% aarmenhoes \
			| ö 		| ö:Ö 		% aambörstig \
			| œ:{öa} 	| œ:{Öa}	% anböadn \
			| Ö:{öa} 	| Ö:{Öa} 	% appelböam \
			| u 		| u:U 		% achterum \
			| Ü:{uu} 	| Ü:{Uu} 	% achtervuur, adjuus  \
			| Ö:{eu} 	| Ö:{Eu}	% achterheufd, bedreuvd \
			| U:{uu} 	| U:{Uu} 	% aanderhalfduumsnagel, \
			| o:{ou} l 				% anhouldn \
			| Ö:{eù} 				% beùksken \
			| ü:{eù} n 				% avergeùnstig \
			\
			%%%%%%%%%%%%%%%%%%%%%%% \
			% apocopy and syncopy % \
			%%%%%%%%%%%%%%%%%%%%%%% \
			\
			| <>:e 					% abbesloet \
			| e:<> n 				% affekoatn (Schreibung von Silibanten) \
			\
			%%%%%%%%%%%%%% \
			% diphthongs % \
			%%%%%%%%%%%%%% \
			\
			| {au}:{ouw} | {au}:{Ouw} 	% anbetrouwn \
			| {au}:{auw} | {au}:{Auw}	% ankauwn \
			| au 		 | {au}:{Au} 	% au, augustus \
			| a:{aa} 	 | a:{Aa} 		\
			| {ei}:{aai} | {ei}:{Aai} 	% aaie-vuurken \
			| {ei}:{ai}  | {ei}:{Ai} 	% aierschoal \
			| Ä:{ea}	 				% andreager \
			| {ei}:{eai} 				% beknmeaisel \
			| E:{ee}	 | E:{Ee} 		% achterbeen \
			| I:{ii} 	 | I:{Ii}		% biidn \
			| å:{oa} 	 | å:{Oa} 		\
			| œ:{öa} 	 | œ:{Öa} 		\
			| {äu}:{öai} | {äu}:{Öai} 	% bemöain \
			| U:{oe} 	 | U:{Oe} 		% altoorkroeper \
			| {Uj}:{oei} 				% alleeloeia \
			| {äu}:{ooi} | {äu}:{Ooi} 	% anknooin \
			| O:{oo} 	 | O:{Oo} 		% anekdoot, anloopn \
			| U:{ouw} 	 | U:{ouw} 		% bidvrouw \
			| ü:{ue} 					% belmuendig \
			| Ü:{ue} 					% beduedn \
			| {äu}:{ui}  | {äu}:{Ui}	% anbuitn \
			| {äu}:{uui} | {äu}:{Uui}	% ankruuin \
			| Ö:{ui}  	 | Ö:{Ui}		% anbuitn \
			| Ü:{uu} 	 | Ü:{Uu}		% atjuus \
			| U:{uu} 	 | U:{uu} 		% ankruusn \
			\
			%%%%%%%%%%%%%% \
			% consonants % \
			%%%%%%%%%%%%%% \
			\
			| b 		| b:B 			\
			| x:{ch}	| x:{Ch} 		\
			| S:{sch} 	| S:{Sch} 		\
			| d 		| d:D 			\
			| f 		| f:F 			\
			| g 		| g:G 			\
			| h 		| h:H 			\
			| j 		| j:J 			\
			| k 		| k:K 			\
			| l 		| l:L 			\
			| m 		| m:M 			\
			| n 		| n:N 			\
			| p 		| p:P 			\
			| r 		| r:R 			\
			| s 		| s:S 			\
			| S:s 		| S:S 			\
			| S:{sk}	| S:{Sk}		\
			| t 		| t:T 			\
			| f:v 		| f:V 			\
			| v 						\
			| w 		| w:W 			\
			| s:z 		| s:Z 		% alzookloar \
			\
			%%%%%%%%%% \
			% relics % \
			%%%%%%%%%% \
			\
			<>:['\-]

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



 

 
