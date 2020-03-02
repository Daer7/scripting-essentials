#!/bin/bash

#Dany jest katalog D (pierwszy parametr skryptu). Do wszystkich 
#plików regularnych w D należy dodać prawo zapisu dla właściciela, 
#a katalogom należy odebrać prawo wykonania dla właściciela.

if [ "$#" -eq 0 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument powinien być istniejącym katalogiem"
	exit 1
fi

for f in "$1"/*
do
	if [ -f "$f" ]
	then
		chmod u+w "$f"
	elif [ -d "$f" ]
	then
		chmod u-x "$f"
	fi
done
exit 0
