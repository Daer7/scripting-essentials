#!/bin/bash

#Dany jest katalog D (pierwszy parametr skryptu). 
#Wypisać nazwy wszystkich plików w D. W przypadku plików będących 
#bezpośrednimi podkatalogami D wypisać też nazwy plików, 
#które te podkatalogi zawierają. Ograniczyć się do dwóch poziomów 
#(tzn. wypisać tylko zawartość D i jego podkatalogów, nie głębiej). 
#Wypisywane nazwy powinny posiadać odpowiednią ścieżkę 
#(np. D/plik, D/podkatalog/plik). Można użyć zagnieżdżonej pętli for.

if [ "$#" -eq 0 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument powinien być istniejącym katalogiem"
	exit 1
fi

for f in "$1"/* "$1"/.*
do
	echo "$f"
	if [ -d "$f" ]
	then
		for g in "$f"/*
		do
			echo "$g"
		done
	fi
done
exit 0
