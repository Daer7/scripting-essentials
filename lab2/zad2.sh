#!/bin/bash

#Dany jest katalog D (argument skryptu). Należy w nim zmienić wszystkie 
#dowiązania symboliczne tak by były zdefiniowane ścieżką względną 
#(i wskazywały na to same miejsce co przed zamianą). 
#Stworzenie ścieżki względnej inaczej niż „ręcznie” jest nisko punktowane.

if [ "$#" -eq 0 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument powinien być istniejącym katalogiem"
	exit 1
fi

for f in `ls -A "$1"`
do
	if [ -L "$1"/"$f" ]
	then
		TARGETPATH=`readlink -f "$1"/"$f"`
		RELATIVEPATH=`realpath --relative-to="$1" "$TARGETPATH"`
		ln -fs "$RELATIVEPATH" "$1"/"$f"
	fi
done
exit 0
		
