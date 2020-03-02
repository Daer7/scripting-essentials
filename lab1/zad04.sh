#!/bin/bash

#Dany jest katalog D (pierwszy parametr skryptu). 
#Należy ponumerować wszystkie pliki regularne w D poprzez dodanie 
#na ich końcu członu .N, gdzie N to kolejne liczby naturalne 
#(1, 2, 3 itp.). Numeracja powinna przebiegać według wielkości plików 
#(w dowolną stronę).

if [ "$#" -eq 0 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument nie jest istniejącym katalogiem"
	exit 1
fi

NUM=1
for f in `ls -S $1/*`
do
	if [ -f "$f" ]
	then
		echo "$f"
		mv "$f" "$f"."$NUM"
		NUM=$((NUM+1))
	fi
done
exit 0
