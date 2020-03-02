#!/bin/bash

#Dane są katalog D (pierwszy parametr skryptu) oraz plik regularny P 
#(drugi parametr skryptu). P zawiera (być może pustą) listę 
#(zbiór wierszy). Należy w D utworzyć puste pliki regularne o nazwach 
#zgodnych z tą listą. Jeżeli jakiś plik już istnieje, to nie powinien 
#zostać zniszczony.

if [ "$#" -lt 2 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument 1 nie jest istniejącym katalogiem"
	exit 1
elif [ ! -w "$1" ]
then
	echo "Nie masz uprawnień, by pisać do katalogu w argumencie 1"
	exit 1
elif [ ! -f "$1"/"$2" ]
then
	echo "Argument 2 nie jest istniejącym plikiem regularnym"
	exit 1
elif [ ! -s "$1"/"$2" ]
then
	echo "Lista nazw w argumencie 2 jest pusta"
	exit 1
fi

while IFS= read -r line #IFS to pusty separator
do
	if [ ! -e "$1"/"$line" ]
	then
		touch "$1"/"$line"
	else
		echo Plik "$1"/"$line" już istnieje
	fi
done < "$1"/"$2"
exit 0
	
