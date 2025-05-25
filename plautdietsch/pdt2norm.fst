% normalize to North Markian / North Low Saxon

ALPHABET=[!#&'(),-.:;?{}01345aAäÄbBcCdDeEfFgGhHiIjJkKlLmMnNoOöpPqQrRsStTuUüÜvVwWxyYz] \
		 [aeiouäöüœåÄEIOUÖÜ] [bdfghjklmnpqrstvwxS]

$SPACE$= ([\ ] | [\ ]:{}) (<>:[\ ] | <>:{})* <>:[\t] 

$DROP_SPACE$=(<>:[\ ] || $SPACE$)?

$TO_NORM$=\
			\
			%%%%%%%%%%%%%%%%% \
			% single vowels % \
			%%%%%%%%%%%%%%%%% \
			\
			  a 			| a:A 	% achtel, aufbarschte "abbörsten",  aufdaumpe "abdampfen"\
			| a:{aa} 					% ? haare \
			| Ä:{äa} 		| Ä:{Äa} 	% Äakjel "Ekel" \
			| a:{au}		| a:{Au}	% äakjelhauft "ekelhaft", äatshaulwe "ihrethalben", Adelmaun "Edelmann"; mit pdt. Dehnung \
			| a:{aua} 					% krauaftlooss "kraftlos" \
			| å:{oa}		| å:{Oa} 	% Heenaoaft "Hühnerobst", auffoare "abfahren", Alboage "Ellbogen" \
			| Ä:ä 			| Ä:Ä 	% äa "ihr", Äsel "Esel" \
			% | Ä:e 						% ? Fari'sea "Pharisäer" \
			| å:o 			| å:O 		% Äkjekota "Eichkater", Pultaowent "Polterabend" (offene Silben)\
			| e 			| e:E 		% Äkjekota "Eichkater" \
			| e:{ä} 		| e:Ä 		% Ädikj "Essig" \
			| E:{ee} 		| E:{Ee} 	% aufleese "ablesen" \
			| e:a 						% adra'sseare "addressieren", Akjsteen "Eckstein" (statt Schwa vor betontem Vokal?) \
			| E:ä 			| E:Ä 		% Äkj "Eiche" \
			| i 			| i:I 		% Ädikj "Essig" \
			| I:{ie}		| I:{Ie}	% aufbiete "abbeißen" \
			| i:{ii}					% frädliijch "friedlich" \
			| o 			| o:O 		% Äjenkopp "Eigenkopf" \
			| o:{au}		| o:{Au}	% Akjshaulm "Axtholm" \
			| Ö:{ee} 		| Ö:{Ee} 	% Heenaoaft "Hühnerobst", aufkjeepe "abkaufen" \
			| O:{oo} 		| O:{Oo}	% auffoodre "abfüttern", krauaftlooss "kraftlos" \
			| O:{ua}		| O:{Ua} 	% Näajenkluak "Neun(mal)klug" \
			| O:{üa} 		| O:{Üa} 	% Düak "Tuch", A'drassbüak "Addressbuch", Haundüak "Handtuch" \
		%	| Ö:{üa} 			| Ö:{üa}	% ?be'spüake "be-spuken" \
			| O:o 			| O:O 		% Ätstow "Eßstube" \
			| œ:ä 			| œ:Ä 		% äwaschmiete "(her)über schmeißen", aufdräje "abtrocknen" \
			| œ:e 			| œ:E 		% derjchdrenje "durchdrängen" \
			| u 			| u:U 		% Muttakuarn "Mutterkorn" (hd)	\
			| Ü:{ie}		| Ü:{Ie}	% auftiene "abzäunen" \
			| ü:i 			| ü:I 		% Entsindung "Entzündung" (hd) \
			| U:u 			| U 		% Fluchwuat "Fluchwort" (hd), vgl. Wutt "Wut" \
			| U:ü 			| U:Ü 		% Mü'sium "Museum", auffüle "abfaulen", be'süpe "besaufen", Hüss "Haus", Be'schlüte "beschließen" \
			| Ü:ü 				| Ü:Ü 		% Bün "Bühne" (hd) \
			\
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \
			% Niederpreußische Verdumpfung % \
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \
			\
			| o:u l 				% Pultaowent "Polterabend", so auch hp. \
			\
			| e:a [mnfbvl]	 	| e:A [mnfbvl] 		% am "ihm", Wotawalle "Wasserwelle" \
			| e:{au} [mnfbvl] 		| e:{Au} [mnfbvl] 	% Aulfenbeen "Elfenbein" \
			| i:e [mnfbvl]		| i:E [mnfbvl]		% wäaemma "whoever", Äjensennijch "eigensinnig", jlebbrijch "glibberig" \
			| ü:e [mnfbvl] 	| ü:E [mnfbvl]		% Kjensla "Künstler", Beffel "Büffel" \
			| a:{au} [mnfbvl]	| a:{Au} [mnfbvl]	% Learaaumt "Lehreramt" \
			| a:o [mnfbvl]		| a:O [mnfbvl]		% Jeedajemeeenschoft "Jedergemeinschaft" \
			| u:o  [mnfbvl] 	| u:O [mnfbvl] 	% Aufgonst "Abgunst", onnparteiisch "unparteiisch", Loftrua "Luft-rohr" \
			\
			% gaps: (because the rules would be to complicated) \
			% Joaresberejcht "Jahresbericht" \
			% Deschkjlinja "Tischklingler" \
			\
			%%%%%%%%%%%%%%%%%%%%% \
			% postvokalisches r % \
			%%%%%%%%%%%%%%%%%%%%% \
			\
			| {ä}:a r 		| Ä:a r 	% Ar'schaufa "Erschaffer" \
			| {Äger}:{eia} 					% Schrüwendreia "Schraubendreher" \
			| {Är}:{äa} 	| {Är}:{Äa}		% äa "ihr" \
			| {år}:{oa}	(<>:r)?				% äjanoatijch "eigenartig",  Ätwoa "Eßware", auffoare "abfahren" \
			| {ar}:{oa} 					% Boajch "Berg" \
			| {ar}:{oa} 					% fäaoabeide "vorarbeiten" \
			| {år}:{oa} 					% Ruaoatijch "tubular" \
			| {är}:{oa} 					% Boajch "Berg" \
			| {e}:a r 					% Heiarnt "Heuernte", Harscha "Herrscher" \
			| {Er}:{äa} 		| {Er}:{Äa} 	% Luabäablaut "Lorbeerblatt" \ 		
			| {Er}:{ea} 					% Leaordninj "Lehrordnung" \
			| {Er}:{ea} (<>:r)? | {Er}:{Ea} (<>:r)? % fea'tian "14" \
			| {Er}:{ea} (<>:r)? | {Er}:{Ea} (<>:r)? % Nuadstearn "Nordstern" \
			| {Er}:{ea} | {Er}:{Ea}			% achtungsweat "achtungswert" \
			| {Er}:{ear} 					% adra'sseare \
			| {er}:{oa} 					% Boajch "Berg" \
			| {er}:a 				% Wotawalle "Wasserwelle" \
			| {Erd}:{ea} | {Erd}:{Ea}		% eana "irden" \
			| {fer}:{fe}	| {fer}:{Fe} % Aunkloagsfeträda "Anklagevertreter" \
			| {Iger}:{ia}					% Schwiaellre "Schwiegereltern" \
			| {Iger}:{ia} 					% Schwiaellre "Schwiegereltern" \
			| {ir}:{ea} 					% Gaustweat "Gastwirt" \
			| {Ir}:{ia} (<>:r)? | {Ir}:{Ia} (<>:r)? % Be'jia "Begier" \
			| {œr}:{äa} 	| {œr}:{Äa} % fäaoabeide "vorarbeiten" \
			| {œr}:{ua} 					% Loftruaentsindung "Luftröhrenentzündung"\
			| {ör}:{ar} 					% kjarpalijch "körperlich" \
			| {Or}:{ua}			| {Or}:{ua}	% Aufganksrua "Abgangsrohr", Auntwuat "Antwort" \
			| {or}:{ua} 			% Wuat "Wort" \
			| {or}:{ua} 		| {or}:{ua} 	% Luabäablaut "Lorbeerblatt" \
			| {or}:{ua} 					% wuaemma "wherever"\
			| {Ü}:{ee} 		| Ü:{Ee}	% Äjendeema "Eigentümer" \
			| {u}:{ua} (<>:r)? | u:{Ua} (<>:r)? % Uarkaun	"Hurrican" \
			| {Ür}:{ia} (<>:r)? | {Ür}:{Ia} (<>:r)? % ennmiare "einmauern", Fia "Feuer" \
			| {Ur}:{ua} 		| {Ur}:{ua} 	% Flua "Flur" \
			| {Ur}:{üa} (<>:r)? 	| {Ur}:{Üa} (<>:r)? % derjchbüare "durch-bauern, d.h., abwirtschaften" \
			| {Ur}:{üa} (<>:r)? 		% Fi'güa "Figur" \
			\
			%%%%%%%%%%%%%%%%%%%%%%% \
			% apocopy and syncopy % \
			%%%%%%%%%%%%%%%%%%%%%%% \
			\
			| <>:e						% Äkjekota "Eichkater" \
			\
			%%%%%%%%%%%%%% \
			% diphthongs % \
			%%%%%%%%%%%%%% \
			\
			| {ei}:{äaj} 	| {ei}:{Äaj} % Äajdakjsel "Eidechse" \
			| {ei}:{eee}	| {ei}:{Eee} 	% Jeedajemeeenschoft "Jedergemeinschaft" \
			| au 							% aufkaue "abkauen" \
			| ei 			| {ei}:{Ei}		% Äjenheit "Eigenheit" \
			| {äu}:{ei}		| {äu}:{Ei}		% Schleia "Schleier", Heiarnt "Heuernte" \
			\
			| {ei}:{ia}		| {ei}:{Ia}		% achtian "18"\
			| {äu}:{ei} 					% Äwatseiung "Überzeugung" \
			| ei 							% Fe'sseiung "Prophezeiung" \
			\
			% sekundäre (pseudo-)diphthonge \
			| {E'i}:{eei}					% schneeijch "verschneit" \
			| {I'a}:{ia} 					% Dia'maunt \
			| {ig}:{iee}					% schriee "schneien" (nmk. schnien, schniggen) \
			| {I'e}:{iee} 					% schriee "schneien" (nmk. schnien, schniggen) \
			| {uge}:{üe}		| {uge}:{Üe} % büe "bauen" \
			| {Ähi}:{äi} 					% fäijch "fähig" \
			| {uge}:{üe}	| {U'e}:{üe}	% büe "bauen" \
			| {uhi}:{üi}				% rüijch "ruhig" \
			\
			%%%%%%%%%%%%%% \
			% consonants % \
			%%%%%%%%%%%%%% \
			\
			| b 		| B 	% b (Anlaut) \
			| x:{jch} 			% Änlijchkjeit "Ähnlichkeit", äakjlijch "eklig" \
			| x:{ch}	| x:{Ch} % acht "8" \
			| k:{ck} 			% Acka "Acker" \
			| S:{sch} 	| S:{Sch} % Aufscheet "Abschied" \
			| S:{zh}	| S:{Zh} % rüzhe "rauschen"; pdt /zh/ statt nds. /S/, bes. für LW, vgl. Be'zhuj "Burgois" \
			| d 		| d:D 	% Äjendeema "Eigentümer" \
			| f 		| f:F 	% Äjenschoft "Eigenschaft" (Anlaut) \
			| v:f 				% be'looft "belaubt", Be'jrafniss "Begräbnis" (Auslaut) \
			| f:{ff}			% Be'jriff "Begriff" \
			| g 		| g:G 	\
			| g:{gj} 	| g:{Gj} % Agj "Ecke" \
			| h 		| h:H 	% nur anlaut, nicht zum Anzeigen der Vokallänge verwendet \
			| k:{kj}		| k:{Kj}	% Ädikj "Essig", Äkj "Eiche", Kjräajel \
			| x:{jch}			% s.o. \
			| {nd}:{nj}			% Aufbinjsel "Abbindsel", nmk. nd > nn \
			| {nn}:{nj}	 		% Aufbinjsel "Abbindsel", nmk. nd > nn \
			| {ng}:{nj} 		% Leaordninj "Lehrordnung", Benjel "Bengel" \
			| j 		| J 	% Joaresberejcht "Jahresbericht" \
			| g:j 		| g:J	% Äjendeema "Eigentümer", (äats)jlikje "(ihres)gleichen", jlebbrijch "glibberig", äjen "eigen" \
			| {ig}:j 			% Je'waultja "Gewaltiger" \
			| k 		| k:K 	\
			| k:{ck}			\
			| k:{kj} 	| k:{Kj} \
			| {ng}:{nk}			% Aufganksrua "Abgangsrohr" \
			| l 		| l:L 	\
			| m 		| m:M 	\
			| n 		| n:N \
			| p 		| p:P 	\
			| r 		| r:R 	% nur Anlaut, da sonst assimiliert \
			| s 		| s:S 	% Wotawalkjes "Wasserwell-chen" \
			| S:{sch}	| S:{Sch} % Wunsch \
			| r s:{sch} 		% Worscht \
			| t 		| t:T 	\
			| w 		| w:W 	% Wulf (nur Anlaut) \
			| v:w 				% driewe "treiben" (nicht Anlaut)\
			| {ts}:{tz}	| ts 	% Waultz "Walzer" \
			| S:{zh}	| S:{Zh} % s.o. \
			| {ts}:z 			% Luabäakraunz "Lorbeerkranz" (hd) \
			\
			%%%%%%%%%%%%%%%%% \
			% assimilations % \
			%%%%%%%%%%%%%%%%% \
			\
			| {er}:{re} 					% jistreowent "gestern abend" \
			| {är}:{or}						% metjeorwe "mitgeerbt" \
			\
			%%%%%%%%%% \
			% relics % \
			%%%%%%%%%% \
			\
			<>:['\-!#&(),:;?{}]

% for word-final assimilations
$FINAL$ = {en}:e 			% kaue "kauen" \
		| <>:e 				% friee Konnste "freie Künste" (nmk. Apokopie) \
		| {re}:{ern}		% auffoodre "ab-füttern" \
		| {er}:a 			% Ätwoahendla "Eßwa(ren)händler" \
		| {le}:{eln} 		% aufhoatle "abhärte(l)n" \
		| g:{jch}			% akjijch "eckig", Ar'foljch "Erfolg" \
		| g:{ch}			% Schlach "Schlag" \



% keeping multi-word expressions
% $NORMALIZE$= \
	% $DROP_SPACE$ $TO_NORM$+ ($SPACE$+ $TO_NORM$+)* $DROP_SPACE$ (<>:[\] (<>:.)*)?

% just the first word
% most of these are not MWEs, but contain artifacts, such as numberings
$NORMALIZE$= \
	$DROP_SPACE$ $TO_NORM$+ $FINAL$? $DROP_SPACE$? (<>:[\\] (<>:.)*)?

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

$VALIDATE$=	(! (v .* | .* (sk|sx|bb|dd|ff|gg|jj|kk|ll|mm|nn|pp|rr|ss|tt|vv|xx|SS|jx|jg|gj|kj) .*)) || \
			$NORM_C$* $NORM_V$ ($NORM_C$+ $NORM_V$)* $NORM_C$*

% run it
$VALIDATE$ || $NORMALIZE$ || .* ([\(] .* [\)] .*)* .*

