#!/bin/bash

#Dane są katalog D (pierwszy parametr skryptu) oraz plik regularny P 
#(drugi parametr skryptu). P zawiera (być może pustą) listę 
#(zbiór wierszy). Należy wypisać różnice między D i P, 
#tzn. wypisać listę plików, które są w D, ale nie ma ich na liście P 
#oraz takich, które są na liście P, ale nie ma ich w katalogu D. 
#W zadaniu można wykorzytać jedną zagnieżdżoną pętlę for.

if [ "$#" -lt 2 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument 1 powinien być istniejącym katalogiem"
	exit 1
elif [ ! -f "$1"/"$2" ]
then
	echo "Argument 2 powinien być istniejącym plikiem regularnym"
	exit 1
elif [ ! -s "$1"/"$2" ]
then
	echo "Przekazany plik regularny nie powinien być pusty"
	exit 1
fi

echo "Są na liście, brak w katalogu:"
while IFS= read -r line
do
	if [ ! -e "$1"/"$line" ]
	then
		echo "$line"
	fi
done < "$1"/"$2"

echo

echo "Są w katalogu, brak na liście:"
for f in "$1"/*
do
	NAME=`basename "$f"`
	FOUND=0
	while IFS= read -r line
	do
		if [ "$NAME" = "$line" ]
		then
			FOUND=1
			break
		fi
	done < "$1"/"$2"
	if [ "$FOUND" -eq 0 ]
	then
		echo "$NAME"
	fi
done
exit 0
	
