#!/bin/bash

#Dane są katalogi D1 (pierwszy parametr skryptu) oraz D2 
#(drugi parametr skryptu). Należy wyświetlić listę (nazwy) plików 
#regularnych o identycznych nazwach w obu katalogach. 
#Można użyć więcej niż jednej pętli for, ale nie wolno używać 
#pętli zagnieżdżonych.

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
	if [ -f "$f" ]
	then
		NAME=`basename "$f"`
		if [ -f "$2"/"$NAME" ]
		then
			echo $NAME
		fi
	fi
done
exit 0
