#!/bin/bash

#Dane jest drzewo katalogowe D oraz plik P. Należy stworzyć 2 potoki:
#
#Potok 1:
#
#– dla każdego dowiązania symbolicznego należy wypisać jego 
#(lub ewentualnie celu) nazwę (ostatni człon) zaszyfrowaną 
#dowolnym szyfrem cezara, (3)
#– dla każdego katalogu wypisać liczbę jego (bezpośrednich) 
#ukrytych plików, (3)
#– dla każdego pliku, którego nazwa zaczyna się na literę n lub N 
#wypisać jego ścieżkę bezwzględną z zamianą ukośników na odwrotne. (3)
#Wyniki należy posortować, wysłać do pliku P, odwrócić kolejność linii 
#oraz wyświetlić na ekranie ostatnie 7 wyników. (3)

#Potok 2:
#Należy wyświetlić liczbę plików zwykłych na poszczególnych poziomach drzewa.
#
#Uwaga ogólna: potok ma być postaci komenda find + komenda while. 
#Find ma dostarczać tyle informacji ile może (while ma robić tylko to 
#czego find nie potrafi zrobić).

if [ "$#" -lt 2 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument 1 powinien być istniejącym drzewem katalogowym"
	exit 1
elif [ ! -f "$2" ]
then
	echo "Argument 2 powinien być istniejacym plikiem"
	exit 1
fi

find "$1" \( -type l -printf "%f 1\n" \) , \
\( -type d -printf "%p 2\n" \) , \
\( -type f -iname "n*" -printf "%p 3\n" \)  \
| while read name number
do
	if [ "$number" = 1 ] #szyfr cezara
	then
		name=$(echo "$name" | tr '[A-Za-z]' '[L-ZA-Kl-za-k]')
		echo "$name"
		
	elif [ "$number" = 2 ] #liczba ukrytych plikow
	then
		NUM=0
		for f in `find "$name" -maxdepth 1 -type f -iname ".*" -print`
		do
			NUM=$((NUM+1))
		done
		echo "$NUM"
		
	elif [ "$number" = 3 ] #zamiania ukosnikow
	then
		FLIPPEDPATH=$(realpath "$name" | tr '/' '\\')
		echo "$FLIPPEDPATH"
	
	fi
done | sort | tee "$2" | tac | tail --lines=7


#Zadanie 2

LEVEL=1
FILESONLEVEL=0
find "$1" -type f -printf "%d\n" | sort | ( while read depth
do
	if [ "$depth" = "$LEVEL" ]
	then
		FILESONLEVEL=$((FILESONLEVEL+1))
	else
		echo "${LEVEL} : ${FILESONLEVEL}"
		LEVEL="$depth"
		FILESONLEVEL=1
	fi
done
echo "${LEVEL} : ${FILESONLEVEL}" )
	


