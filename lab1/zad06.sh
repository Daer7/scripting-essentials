#!/bin/bash

#Dane są katalogi D1 (pierwszy parametr skryptu) oraz D2 
#(drugi parametr skryptu). Należy przesunąć wszystkie pliki regularne, 
#do których my (nasz skrypt) mamy prawo wykonania z D1 do D2. 
#Pozostałe pliki w katalogu nie powinny być ruszane.

if [ "$#" -lt 2 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" -o ! -d "$2" ]
then
	echo "Oba argumenty powinny być istniejącymi katalogami"
	exit 1
fi

for f in "$1"/*
do
	if [ -f "$f" -a -x "$f" ]
	then
		mv "$f" "$2"
	fi
done
exit 0
		
