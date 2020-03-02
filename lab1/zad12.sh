#!/bin/bash

#Dany jest katalog D (pierwszy parametr skryptu). 
#Należy wypisać dwie liczby: liczbę wszystkich plików regularnych w D 
#oraz liczbę wszystkich bezpośrednich podkatalogów w D. 
#W obu przypadkach należy wziąć pod uwagę jedynie te pliki, do których 
#my (nasz skrypt) mamy prawo wykonania.

if [ "$#" -eq 0 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument powinien być istniejącym katalogiem"
	exit 1
fi

N=0
M=0

for f in "$1"/*
do
	if [ -x "$f" ]
	then
		if [ -f "$f" ]
		then
			N=$((N+1))
		elif [ -d "$f" ]
		then
			M=$((M+1))
		fi
	fi
done
echo "Plików: $N"
echo "Katalogów: $M"
exit 0
		
