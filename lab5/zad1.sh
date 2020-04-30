#!/bin/bash

#Dany jest plik zwykły P (argument skryptu). Należy wypisać ten plik na 
#ekran z następującymi zmianami (tylko wypisać, 
#bez zmiany oryginalnego pliku):

#1. Ponumerować linie pliku (puste też). (1)
#2. Nie wypisywać treści komentarzy jednolinijkowych C/C++ 
#(pomijać treść od dwuznaku // do końca linii). (2)
#3. Zamienić wszystkie daty formatu DD-MM-YYYY (np. 30-04-2020) na 
#YY/MM/DD (20/04/30). Uwaga: daty mogą występować wielokrotnie 
#w tej samej linii! (4)
#4. Na koniec wypisać nazwy załączonych plików C/C++ (wykrywanie linii 
#typu #include <filename> lub #include "filename"). (3)

if [ "$#" -lt 1 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -f "$1" ]
then
	echo "Argument 1 powinien być istniejacym plikiem"
	exit 1
fi

awk '\
{ nocommentline = gensub (/\/\/.*$/, "", "g");
dateschanged  = gensub(/([0-9]{2})\-([0-9]{2})\-[0-9]{2}([0-9]{2})/, "\\3/\\2/\\1", "g", nocommentline);
if (match (dateschanged, /^[ ]*#include[ ]*<([^> ]+)>[ ]*$/, fname) == 0 )
match (dateschanged, /^[ ]*#include[ ]*"([^" ]+)"[ ]*$/, fname);
if (1 in fname) filenames[fname[1]] = fname[1];
print NR, dateschanged }
END { for (i in filenames) printf("%s\n", filenames[i])}' "$1"
