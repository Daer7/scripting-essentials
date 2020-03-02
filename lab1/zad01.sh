#!/bin/bash

#Dany jest katalog D (pierwszy parametr skryptu). Należy zmienić nazwy 
#wszystkich plików w D, do których my (nasz skrypt) mamy prawo zapisu, 
#przez dopisanie dodatkowego członu ".old".

if [ "$#" -eq 0 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument nie jest istniejącym katalogiem"
	exit 1
fi

for f in "$1"/*
do
	if [ -w "$f" ]
	then
		echo "$f"
		mv "$f" "$f".old
	fi
done

exit 0
