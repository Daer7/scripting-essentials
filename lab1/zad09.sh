#!/bin/bash

#Dany jest katalog D (pierwszy parametr skryptu). 
#Należy usunąć wszystkie bezpośrednie podkatalogi D. 
#Zawartość usuwanych katalogów należy wcześniej przenieść do D. 
#W zadaniu można wykorzystać zagnieżdżoną petlę for.

if [ "$#" -eq 0 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument powinien być istniejącym katalogiem"
	exit 1
fi

for d in "$1"/*
do
	if [ -d "$d" ]
	then
		for f in "$d"/*
		do
			mv "$f" "$1"
		done
		rmdir "$d"
	fi
done
exit 0
