#!/bin/bash


#Dany jest katalog D (pierwszy parametr skryptu). Należy skasować 
#wszystkie pliki regularne i puste katalogi w D, poza tymi do których 
#my (nasz skrypt) mamy prawo wykonania. 
#Uwaga! Katalogi też mogą mieć prawo wykonania!

if [ "$#" -eq 0 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument nie jest istniejącym katalogiem"
	exit 1
fi

for f in "$1"/.* "$1"/* #.* wyszukuje ukryte pliki
do
	if [ ! -x "$f" ]
	then
		if [ -f "$f" ]
		then
			rm "$f"
		elif [ -d "$f" -a ! "$(ls -A $f)" ]
		then
			rm -r "$f"
		fi
	fi
done
exit 0
		
