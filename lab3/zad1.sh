#!/bin/bash

#Dane są drzewa katalogowe D1 oraz D2 (argument skryptu).
#
#Należy w D1 oraz D2:
#
#1. Usunąć wszystkie pliki .png (nie muszą być to prawdziwe png, 
#liczy się rozszerzenie) o rozmiarze mniejszym niż 200 bajtów (2 p).
#
#2. Znaleźć katalogi, do których: właściciel pliku ma prawo odczytu 
#lub inni nie mają prawa wykonania (4 p).
#
#3. Znaleźć linki symboliczne do plików innych niż zwykłe (2 p).
#
#4. Wypisać dla plików zwykłych: numer i-noda, rozmiar pliku oraz 
#datę ostatniej modyfikacji (3 p).

#Wszystkie 4 podpunkty powinny być w jednym findzie. 
#Skrypt będzie wtedy zawierał (oprócz standardowego sprawdzania 
#argumentów) tylko dwie rozbudowane komendy find (jedna dla szukania 
#w D1 oraz jedna dla szukania w D2).
#
#Dodatkowe punkty za:
#a) ograniczenie wyszukiwania do 3 poziomów podkatalogów (1 p).
#b) zrobienie wszystko jednym findem (1 p).

if [ "$#" -lt 2 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument 1 powinien być istniejącym drzewem katalogowym"
	exit 1
elif [ ! -d "$2" ]
then
	echo "Argument 2 powinien być istniejacym drzewem katalogowym"
	exit 1
fi

find "$1" "$2" -maxdepth 3 \( -type f -name "*.png" -size -200c -delete \) , \
\( -type d -perm -400 -o ! -perm -001 -print \) , \
\( -type l ! -xtype f -print \) , \
\( -type f -printf '%i %s %t\n' \)

