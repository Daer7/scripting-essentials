#!/bin/bash

#Dane są katalog D (pierwszy parametr skryptu) oraz nazwa P 
#(drugi parametr skryptu). Należy skasować wszystkie puste 
#(o zerowej wielkości) pliki regularne w D. 
#Należy też utworzyć w D plik regularny o nazwie P, które będzie zawierał 
#listę usuniętych plików.

if [ "$#" -lt 2 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Pierwszy argument powinien być istniejącym katalogiem"
	exit 1
fi

for f in "$1"/* "$1"/.*
do
	if [ -f "$f" -a ! -s "$f" ]
	then
		echo `basename "$f"` >> "$1"/"$2"
		rm "$f"
	fi
done
exit 0
		
