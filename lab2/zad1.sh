#!/bin/bash

#Dany jest katalog D oraz plik zwykły P (dwa argumenty skryptu). 
#Należy w D usunąć wszystkie dowiązania symboliczne wiszące (zepsute) 
#a następnie zamienić wszystkie dowiązania symboliczne w D do pliku P 
#na dowiązania twarde.

if [ "$#" -lt 2 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument 1 powinien być istniejącym katalogiem"
	exit 1
elif [ ! -f "$2" ]
then
	echo "Argument 2 powinien być istniejacym plikiem regularnym"
	exit 1
fi

for f in `ls -A "$1"`
do
	if [ -L "$1"/"$f" -a ! -e "$1"/"$f" ]
	then
		rm "$1"/"$f"
	fi
done


for f in `ls -A "$1"`
do
	if [ -L "$1"/"$f" ]
	then
		TARGETPATH=`readlink -e "$1"/"$f"`
		if [ "$TARGETPATH" -ef "$2" ] # porownanie numerow inode celow
		then
			ln -f "$TARGETPATH" "$1"/"$f"
		fi
	fi
done

exit 0
