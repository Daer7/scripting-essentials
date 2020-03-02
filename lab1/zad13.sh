#!/bin/bash


#Dane są katalog D (pierwszy parametr skryptu), plik regularny P 
#(drugi parametr skryptu) oraz ścieżka W (trzeci argument skryptu). 
#P zawiera (być może pustą) listę (zbiór wierszy). Należy utworzyć 
#plik regularny W, którego zawartość będzie połączoną zawartością 
#plików regularnych z listy z pliku P. Kolejność w jakiej pliki 
#zostaną połączone powinna być zgodna z kolejnością na liście P. 
#Treść każdego pliku powinna być poprzedzona nagłówkiem z jego nazwą.

if [ "$#" -lt 3 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument 1 powinien być istniejącym katalogiem"
	exit 1
elif [ ! -f "$1"/"$2" ]
then
	echo "Argument 2 powinien być istniejącym plikiem regularnym"
	exit 1
elif [ ! -s "$1"/"$2" ]
then
	echo "Przekazany plik regularny nie może być pusty"
	exit 1
fi

while IFS= read -r line
do
	echo "$line" >> "$3"
	cat "$1"/"$line" >> "$3"
	echo >> "$3"
done < "$1"/"$2"
