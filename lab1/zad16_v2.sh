#!/bin/bash

#Dane są katalog D (pierwszy parametr skryptu) oraz plik regularny P 
#(drugi parametr skryptu). P zawiera (być może pustą) listę 
#(zbiór wierszy). Należy wypisać różnice między D i P, tzn. 
#wypisać listę plików, które są w D, ale nie ma ich na liście P 
#oraz takich, które są na liście P, ale nie ma ich w katalogu D. 
#W zadaniu można wykorzytać jedną zagnieżdżoną pętlę for.

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
elif [ ! -s "$2" ]
then
	echo "Lista w pliku nie powinna być pusta"
fi

echo "Są w katalogu, brak na liście: "
for f in `ls -a "$1"`
do
	FOUND=0
	for line in `cat "$2"` 
	do 
		if [ "$f" = "$line" ]
		then
			FOUND=1
			break
		fi
	done
	
	if [ "$FOUND" -eq 0 ]
	then
		echo "$f"
	fi
done


echo "Są na liście, brak w katalogu: "
for line in `cat "$2"`
do
	if [ ! -e "$1"/"$line" ]
	then
		echo "$line"
	fi
done

exit 0
	
