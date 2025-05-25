#!/usr/bin/env python
# coding: utf-8

# RDF conversion for the Wöhrner Wöör (WöWö) dictionary of North Low Saxon (Dithmarschen)
# 
# source:
# Peter Neuber, Wöhrner Wöör, Niederdeutsches Wörterbuch aus Dithmarschen, Stand: 2019-01-01
#
# contributors
# - original Jupyter Notebook by Tabea Gröger, UniA
# - conversion to Python by Christian Chiarcos, UniA

import sys,os,re,argparse
from xml.etree import ElementTree as ET
import pandas as pd
import urllib.parse

args=argparse.ArgumentParser(description="""apply to unzipped WöWö docx root folders (i.e., those that contain word/document.xml)""")
args.add_argument("folders", type=str, nargs="+", help="unzipped docx root folder(s). Must contain word/document.xml")
args.add_argument("-d", "--target_dir", type=str, nargs="?", help="target directory, defaults to .", default=".")

args=args.parse_args()

if not os.path.exists(args.target_dir):
    sys.stderr.write(f"creating target directory {args.target_dir}\n")
    os.makedirs(args.target_dir)

sheets=[]

# ### 1) Konvertierung Wörterbuch XML in CSV-Tabelle

# XML Dokument  parsen
for file_path in args.folders:
    sys.stderr.write(f"reading {file_path}\n")
    document=os.path.join(file_path,"word","document.xml")
    tree = ET.parse(document)
    root = tree.getroot()
    sys.stderr.flush()

    # namespaces definieren
    namespaces = {
        'w': "http://schemas.openxmlformats.org/wordprocessingml/2006/main"
    }

    # alle <w:r> Elemente mit Inhalten extrahieren
    rows = []
    for r in root.findall('.//w:r', namespaces):
        # Text aus <w:t> extrahieren
        text_elem = r.find('.//w:t', namespaces)
        text = text_elem.text if text_elem is not None else ''

        # Formatierungsinfos aus <w:rPr> extrahieren
        rPr_elem = r.find('./w:rPr', namespaces)
        # Variablen font, color, size anlegen
        font = color = size = None

        if rPr_elem is not None:
            # font extrahieren
            font_elem = rPr_elem.find('./w:rFonts', namespaces)
            font = font_elem.get('{http://schemas.openxmlformats.org/wordprocessingml/2006/main}ascii') if font_elem is not None else None

            # color extrahieren
            color_elem = rPr_elem.find('./w:color', namespaces)
            color = color_elem.get('{http://schemas.openxmlformats.org/wordprocessingml/2006/main}val') if color_elem is not None else None

            # size extrahieren
            size_elem = rPr_elem.find('./w:sz', namespaces)
            size = size_elem.get('{http://schemas.openxmlformats.org/wordprocessingml/2006/main}val') if size_elem is not None else None
     
        # falls <w:sym> vorhanden, die Schriftart ersetzen (z.B. für Wingdings)
        sym_elem = r.find('./w:sym', namespaces)
        if sym_elem is not None:
            font = sym_elem.get('{http://schemas.openxmlformats.org/wordprocessingml/2006/main}font')
            
        # Formatierungsinfos in einer Zelle kombinieren
        formatting = f"Font: {font}, Color: {color}, Size: {size}"
        rows.append((text, formatting))
        sys.stderr.write(f"\rread {len(rows)} lines")
        sys.stderr.flush()

    sys.stderr.write("\n")
    sys.stderr.flush()

    # Dataframe anlegen
    df = pd.DataFrame(rows, columns=["Text", "Formatting"])

    # optional: Dataframe als csv Datei speichern
    sys.stderr.write(f"saved as "+file_path+".csv")
    df.to_csv(file_path+".csv", index=False)
    sys.stderr.write("\n")
    sys.stderr.flush()

    # ### 2) Textblöcke mit gleichen Formatierungen mergen

    # Liste für gemergte Ergebnisse
    merged_rows = []

    # Variablen anlegen für die Iteration
    previous_color = None
    previous_size = None
    current_text = ""
    current_font = None  # Zur Nachverfolgung, aber erlaubt Veränderungen

    # durch alle Zeilen im Dataframe iterieren
    for n,(_, row) in enumerate(df.iterrows()):
        text, formatting = row["Text"], row["Formatting"]
        
        # Formatierungsinfos extrahieren
        font = None
        color = None
        size = None
        if "Font:" in formatting:
            font = formatting.split(",")[0].split(":")[1].strip()
        if "Color:" in formatting:
            color = formatting.split(",")[1].split(":")[1].strip()
        if "Size:" in formatting:
            size = formatting.split(",")[2].split(":")[1].strip()

        # wenn size und color gleich bleiben, Text zusammenfügen
        if color == previous_color and size == previous_size:
            current_text += text
        else:
            # wenn size oder color wechselt, die bisher gesammelten Daten speichern
            if previous_color is not None and previous_size is not None:
                merged_rows.append({
                    "Text": current_text,
                    "Formatting": f"Font: {current_font}, Color: {previous_color}, Size: {previous_size}"
                })
            # aktuelle Zeile als Start für einen neuen Block
            current_text = text
            current_font = font
            previous_color = color
            previous_size = size
        sys.stderr.write(f"\rmerge {n} lines")
        sys.stderr.flush()

    sys.stderr.write("\n")
    sys.stderr.flush()

    # letzten Block hinzufügen
    if current_text and previous_color is not None and previous_size is not None:
        merged_rows.append({
            "Text": current_text,
            "Formatting": f"Font: {current_font}, Color: {previous_color}, Size: {previous_size}"
        })

    # neuer Dataframe mit gemergten Ergebnissen
    merged_df = pd.DataFrame(merged_rows)

    # optional: Gemergte Tabelle als CSV speichern
    sys.stderr.write(f"save as "+file_path+"_merged.csv")
    merged_df.to_csv(file_path+"_merged.csv", index=False)
    sys.stderr.write("\n")
    sys.stderr.flush()


    # ### 3) CSV-Tabelle als Grundlage für RDF

    # gemergte Tabelle einlesen
    sys.stderr.write(f"read from "+file_path+"_merged.csv")
    merged_table = pd.read_csv(file_path+"_merged.csv")
    sys.stderr.write("\n")
    sys.stderr.flush()

    # Zeilen neuer Tabelle anlegen
    result_rows = []

    # Variablen zur Verfolgung des aktuellen Hauptlemmas, Sublemmas und der Übersetzung
    current_hauptlemma = None
    current_sublemma = None
    current_translation = None

    # Schleife durch die gemergte Tabelle
    for index, row in merged_table.iterrows():
        text = row["Text"]
        formatting = row["Formatting"]
        
        # Hauptlemma extrahieren (Font: Arial, Color: C00000, Size: 20)
        if formatting == "Font: Arial, Color: C00000, Size: 20":
            # prüfen, ob vorher "µ" als Marker kam
            if index > 0 and merged_table.loc[index - 1, "Text"] == "µ":
                current_hauptlemma = text

                # wenn in folgender Zeile Ziffer (mit Formatierung Color: 333300, Size: 16) steht, Index dem Hauptlemma anfügen
                next_text = str(merged_table.loc[index + 1, "Text"])
                next_formatting = str(merged_table.loc[index + 1, "Formatting"])
                if next_formatting == "Font: None, Color: 333300, Size: 16":
                        current_hauptlemma += f"{next_text}"

                current_sublemma = None  # Reset Sublemma, da ein neues Hauptlemma beginnt
                current_translation = None  # Reset Übersetzung

        # Sublemma extrahieren (Font: Arial, Color: C00000, Size: 16)
        elif formatting == "Font: Arial, Color: C00000, Size: 16":
            # prüfen, ob vorher Marker für Sublemma kam (2 Arten grüner Punkte)
            if index > 0 and (merged_table.loc[index - 1, "Formatting"] == "Font: Wingdings 2, Color: 33CC33, Size: 18" or merged_table.loc[index - 1, "Formatting"] == "Font: Wingdings 2, Color: 66FF33, Size: 16"):
                current_sublemma = text
                current_translation = None  # Reset Übersetzung
        
        # Übersetzung + Zusatz extrahieren (Font: Arial Narrow, Color: 0070C0, Size: 20)
        elif formatting == "Font: Arial Narrow, Color: 0070C0, Size: 20":
            if current_hauptlemma:
                # prüfen, ob Semikolon in der Zeile davor steht -> weitere Übersetzung
                previous_text = str(merged_table.loc[index - 1, "Text"]) if index > 0 else ""
                if current_translation is None or ";" in previous_text:
                    # Übersetzung hinzufügen
                    current_translation = text
                    if not current_sublemma:
                        result_rows.append([current_hauptlemma, None, text, None, None])
                    else:
                        result_rows.append([current_hauptlemma, current_sublemma, text, None, None])
                else:
                    # kein Semikolon -> Text in Zusatz-Spalte packen
                    if not current_sublemma:
                        result_rows.append([current_hauptlemma, None, None, text, None])
                    else:
                        result_rows.append([current_hauptlemma, current_sublemma, None, text, None])
        
        # IPA-Infos extrahieren (Font: Estrangelo Edessa, Color: 666633, Size: 16)
        elif formatting == "Font: Estrangelo Edessa, Color: 666633, Size: 16":
            # nur wenn in folgender Zeile KEINE "]" steht (sonst niederländische IPA)
            if text.startswith("[") and text.endswith("]") and "]" not in str(merged_table.loc[index + 1, "Text"]):
                # IPA-Info passender Zeile hinzufügen
                for row in reversed(result_rows):
                    if row[2] == current_translation and row[4] is None:
                        row[4] = text
                        break
        sys.stderr.write(f"\rprocessed {index} lines")
        sys.stderr.flush()

    sys.stderr.write("\n")
    sys.stderr.flush()


    # Neue Tabelle erstellen
    result_table = pd.DataFrame(result_rows, columns=["Hauptlemma", "Sublemma", "Übersetzung", "Zusatz", "IPA"])

    # Optional: Tabelle als CSV speichern (Name anpassen)
    sys.stderr.write("save > "+file_path+"_result_2_table.csv")
    result_table.to_csv(file_path+"_result_2_table.csv", index=False)
    sheets.append(result_table)
    sys.stderr.write("\n")
    sys.stderr.flush()

# ### 4) Konvertierung XLSX in RDF (Turtle-Format)
# #### 4.1 Hauptlemmata -> LexicalEntries (mit lexicog:subComponents)

# Beide Sheets zusammenführen
if True: # just for indentation
    woewoe_table = pd.concat(sheets, ignore_index=True)

    # Namespaces für Turtle
    BASE_NAMESPACE = "https://nds-spraakverarbeiden.github.io/linked-nds-dictionaries/woewoe.ttl#"
    ONTOLEX_NAMESPACE = "http://www.w3.org/ns/lemon/ontolex#"
    LIME_NAMESPACE = "http://www.w3.org/ns/lemon/lime#"
    LEXICOG_NAMESPACE = "http://www.w3.org/ns/lemon/lexicog#"
    #NEUBER_NAMESPACE = "http://example.org/neuber#"
    VARTRANS_NAMESPACE = "http://www.w3.org/ns/lemon/vartrans#"

    output_lines = []

    # Turtle-Header
    output_lines.append(f"@prefix : <{BASE_NAMESPACE}> .")
    output_lines.append(f"@prefix ontolex: <{ONTOLEX_NAMESPACE}> .")
    output_lines.append(f"@prefix lime: <{LIME_NAMESPACE}> .")
    output_lines.append(f"@prefix lexicog: <{LEXICOG_NAMESPACE}> .\n")
    output_lines.append(f"@prefix vartrans: <{VARTRANS_NAMESPACE}> .\n")

    # Gruppierung nach Hauptlemma
    grouped = woewoe_table.groupby('Hauptlemma')

    # Schleife durch Hauptlemmata
    for n,(hauptlemma, group) in enumerate(grouped):
        lemma_id = urllib.parse.quote_plus(re.sub(r"[\s.!?,;\-]+","_",hauptlemma))
        sense_id = f"{lemma_id}_sense"
        
        # alle zugehörigen Sublemmata aggregieren und einzigartig machen
        sublemmata = group['Sublemma'].dropna().unique() 
        sublemma_ids = [urllib.parse.quote_plus(re.sub(r"[\s.!?,;\-]+","_",sublemma)) for sublemma in sublemmata]

        # LexicalEntry für Hauptlemma
        output_lines.append(f":{lemma_id}_de a ontolex:LexicalEntry;")
        output_lines.append(f"    lime:language \"de\" ;")
        output_lines.append(f"    ontolex:canonicalForm [")
        output_lines.append(f"        a ontolex:Form ;")
        output_lines.append(f"        ontolex:writtenRep \"{hauptlemma}\"@de")
        output_lines.append(f"    ] ;")
        output_lines.append(f"    ontolex:sense :{sense_id}_de .")
        
        # LexicalSense für Hauptlemma erzeugen
        output_lines.append(f"\n\n:{sense_id}_de a ontolex:LexicalSense .\n")

        # Sublemmata als lexicog:subComponents hinzufügen
        if sublemma_ids:
            output_lines.append(f"\n\n:lex_{lemma_id} a lexicog:Entry;")
            output_lines.append(f"     lexicog:describes :{lemma_id}_de;")
            sub_entries = " , ".join(f":lex_{sid}" for sid in sublemma_ids)
            output_lines.append(f"     lexicog:subComponent {sub_entries} .")

            for sid in sublemma_ids:
                output_lines.append(f"\n\n:lex_{sid} a lexicog:LexicographicComponent ;")
                output_lines.append(f"     lexicog:describes :{sid}_de .")

        sys.stderr.write(f"\rexport {n} lemmas")
        sys.stderr.flush()

    # Turtle-Datei speichern
    rdf_output_file_path = os.path.join(args.target_dir,"woewoe_haupt_rdf.ttl")
    sys.stderr.write(f"\rexport {n} lemmas > {rdf_output_file_path}")
    with open(rdf_output_file_path, "a", encoding="utf-8") as rdf_file:
        rdf_file.write("\n".join(output_lines))
    sys.stderr.write("\n")

    # #### 4.2 Sublemmata -> LexicalEntries

    # Namespaces für Turtle
    BASE_NAMESPACE = "https://nds-spraakverarbeiden.github.io/linked-nds-dictionaries/woewoe.ttl#"
    ONTOLEX_NAMESPACE = "http://www.w3.org/ns/lemon/ontolex#"
    LIME_NAMESPACE = "http://www.w3.org/ns/lemon/lime#"
    NEUBER_NAMESPACE = "http://example.org/neuber#"
    VARTRANS_NAMESPACE = "http://www.w3.org/ns/lemon/vartrans#"

    output_lines = []

    # Turtle-Header
    output_lines.append(f"@prefix : <{BASE_NAMESPACE}> .")
    output_lines.append(f"@prefix ontolex: <{ONTOLEX_NAMESPACE}> .")
    output_lines.append(f"@prefix lime: <{LIME_NAMESPACE}> .")
    output_lines.append(f"@prefix lexicog: <{LEXICOG_NAMESPACE}> .\n")
    output_lines.append(f"@prefix vartrans: <{VARTRANS_NAMESPACE}> .\n")

    # Gruppierung nach Sublemma
    grouped = woewoe_table.groupby('Sublemma')

    # Schleife durch Sublemmata
    for n,(sublemma, group) in enumerate(grouped):
        sublemma_id = urllib.parse.quote_plus(re.sub(r"[\s.!?,;\-]+","_",sublemma))
        sense_id = f"{sublemma_id}_sense"
        
        # LexicalEntry für Sublemma
        output_lines.append(f":{sublemma_id}_de a ontolex:LexicalEntry;")
        output_lines.append(f"    lime:language \"de\" ;")
        output_lines.append(f"    ontolex:canonicalForm [")
        output_lines.append(f"        a ontolex:Form ;")
        output_lines.append(f"        ontolex:writtenRep \"{sublemma}\"@de")
        output_lines.append(f"    ] ;")
        output_lines.append(f"    ontolex:sense :{sense_id}_de ")
        # LexicalSense für Sublemma erzeugen
        output_lines.append(f".\n\n:{sense_id}_de a ontolex:LexicalSense .\n")
        sys.stderr.write(f"\rexport {n} sub-lemmas")
        sys.stderr.flush()

    # Turtle-Datei speichern
    rdf_output_file_path = os.path.join(args.target_dir,"woewoe_sub_rdf.ttl")
    sys.stderr.write(f"\rexport {n} lemmas > "+rdf_output_file_path+"\n")
    with open(rdf_output_file_path, "a", encoding="utf-8") as rdf_file:
        rdf_file.write("\n".join(output_lines))
    sys.stderr.flush()

    # Namespaces für Turtle
    BASE_NAMESPACE = "https://nds-spraakverarbeiden.github.io/linked-nds-dictionaries/woewoe.ttl#"
    ONTOLEX_NAMESPACE = "http://www.w3.org/ns/lemon/ontolex#"
    LIME_NAMESPACE = "http://www.w3.org/ns/lemon/lime#"
    NEUBER_NAMESPACE = "http://example.org/neuber#"
    VARTRANS_NAMESPACE = "http://www.w3.org/ns/lemon/vartrans#"

    output_lines = []

    # Turtle-Header
    output_lines.append(f"@prefix : <{BASE_NAMESPACE}> .")
    output_lines.append(f"@prefix ontolex: <{ONTOLEX_NAMESPACE}> .")
    output_lines.append(f"@prefix lime: <{LIME_NAMESPACE}> .")
    output_lines.append(f"@prefix lexicog: <{LEXICOG_NAMESPACE}> .\n")
    output_lines.append(f"@prefix vartrans: <{VARTRANS_NAMESPACE}> .\n")

    # Schleife durch Tabelle
    for i in range(len(woewoe_table)):
        row = woewoe_table.iloc[i]
        if pd.notna(row['Übersetzung']):  # Neue Hauptzeile mit Übersetzung
            translation_id = urllib.parse.quote_plus(re.sub(r"[\s.!?,;\-]+","_",row['Übersetzung']))
            sense_id = f"{translation_id}_sense"
            
            output_lines.append(f":{translation_id} a ontolex:LexicalEntry;")
            output_lines.append(f"    lime:language \"nds\" ;")
            output_lines.append(f"    ontolex:canonicalForm [")
            output_lines.append(f"        a ontolex:Form ;")
            output_lines.append(f"        ontolex:writtenRep \"{row['Übersetzung']}\"@nds")
            
            # prüfen, ob IPA-Info vorhanden ist
            if pd.notna(row['IPA']):
                output_lines.append(f"        ; ontolex:phoneticRep \"{row['IPA']}\"@nds-fonipa")
            
            output_lines.append(f"    ] ;")
            
            # prüfen, ob in der nächsten Zeile eine Zusatzform (z.B. Plural) steht
            if i + 1 < len(woewoe_table):
                next_row = woewoe_table.iloc[i + 1]
                if pd.notna(next_row['Zusatz']):
                    # als otherForm anlegen
                    output_lines.append(f"    ontolex:otherForm [")
                    output_lines.append(f"        a ontolex:Form ;")
                    output_lines.append(f"        ontolex:writtenRep \"{next_row['Zusatz']}\"@nds")
                    output_lines.append(f"    ] ;")
            
            output_lines.append(f"    ontolex:sense :{sense_id}_nds .\n")
            output_lines.append(f":{sense_id}_nds a ontolex:LexicalSense .\n")
        sys.stderr.write(f"\rexport {i} senses")

    # Turtle-Datei speichern
    rdf_output_file_path = os.path.join(args.target_dir,"woewoe_nds_rdf.ttl")
    sys.stderr.write(f"\rexport {i} senses > "+rdf_output_file_path+"\n")
    with open(rdf_output_file_path, "a", encoding="utf-8") as rdf_file:
        rdf_file.write("\n".join(output_lines))


    # #### 4.4 vartrans:translation

    # Pfade zu den RDF-Dateien
    #nds_path = 'woewoe_nds_rdf.ttl'
    #de_path = 'woewoe_de_rdf.ttl'

    # Namespaces für Turtle
    BASE_NAMESPACE = "https://nds-spraakverarbeiden.github.io/linked-nds-dictionaries/woewoe.ttl#"
    ONTOLEX_NAMESPACE = "http://www.w3.org/ns/lemon/ontolex#"
    LIME_NAMESPACE = "http://www.w3.org/ns/lemon/lime#"
    NEUBER_NAMESPACE = "http://example.org/neuber#"
    VARTRANS_NAMESPACE = "http://www.w3.org/ns/lemon/vartrans#"

    output_lines = []

    # Turtle-Header
    output_lines.append(f"@prefix : <{BASE_NAMESPACE}> .")
    output_lines.append(f"@prefix ontolex: <{ONTOLEX_NAMESPACE}> .")
    output_lines.append(f"@prefix lime: <{LIME_NAMESPACE}> .")
    output_lines.append(f"@prefix lexicog: <{LEXICOG_NAMESPACE}> .\n")
    output_lines.append(f"@prefix vartrans: <{VARTRANS_NAMESPACE}> .\n")

    translation_id = 1

    for n,(_, row) in enumerate(woewoe_table.iterrows()):
        # sicherstellen, dass die Zellen gültige Strings enthalten
        nds_term = urllib.parse.quote_plus(re.sub(r"[\s.!?,;\-]+","_",str(row["Übersetzung"]))) if pd.notna(row["Übersetzung"]) else ""
        de_term = urllib.parse.quote_plus(re.sub(r"[\s.!?,;\-]+","_",str(row["Hauptlemma"]))) if pd.notna(row["Hauptlemma"]) else ""
        sublemma_term = urllib.parse.quote_plus(re.sub(r"[\s.!?,;\-]+","_",str(row["Sublemma"]))) if pd.notna(row["Sublemma"]) else ""

        # überspringen, wenn keine Übersetzung in der Zeile steht
        if nds_term is None or nds_term == "":
            continue
        
        # Hauptlemma nehmen, wenn kein Sublemma in der Zeile steht
        if sublemma_term:
            de_term = sublemma_term
        
        # senses der Begriffe verknüpfen
        nds_sense = f":{nds_term}_sense_nds"
        de_sense = f":{de_term}_sense_de"
        
        # translation Eintrag erstellen
        output_lines.append(f":translation_{translation_id} a vartrans:Translation;")
        output_lines.append(f"    vartrans:source {de_sense} ;")
        output_lines.append(f"    vartrans:target {nds_sense} .\n")
        
        translation_id += 1
        sys.stderr.write(f"\rexport {n} translations")

    # Turtle-Datei speichern
    rdf_output_file_path = os.path.join(args.target_dir,"woewoe_translations_rdf.ttl")
    sys.stderr.write(f"\rexport {n} translations > "+rdf_output_file_path+"\n")

    with open(rdf_output_file_path, "a", encoding="utf-8") as rdf_file:
        rdf_file.write("\n".join(output_lines))

    sys.stderr.flush()

