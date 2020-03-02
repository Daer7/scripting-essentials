#!/bin/bash

#Dany jest katalog D (pierwszy parametr skryptu). 
#Dla wszyskich plików w D, do których my (nasz skrypt) mamy prawo zapisu 
#należy zmienić czas ostatniej modyfikacji na czas aktualny.

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
	if [ -w "$f" ]
	then
		touch "$f"
	fi
done
exit 0
