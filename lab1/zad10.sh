#!/bin/bash


#Dane są katalogi D1 (pierwszy parametr skryptu) oraz D2 
#(drugi parametr skryptu). Należy z D1 usunąć wszystkie pliki regularne, 
#które mają swoje odpowiedniki w D2 (tzn. w D2 też są plikami regularnymi 
#o tej samej nazwie).

if [ "$#" -lt 2 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" -o ! -d "$2" ]
then
	echo "Argumenty powinny być istniejącymi katalogami"
	exit 1
fi

for f in "$1"/*
do
	NAME=`basename "$f"`
	if [ -f "$f" -a -f "$2"/"$NAME" ]
	then
		rm "$f"
	fi
done
exit 0
		
