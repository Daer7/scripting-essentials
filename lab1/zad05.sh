#!/bin/bash


#Dany jest katalog D (pierwszy parametr skryptu). 
#Należy wypisać na ekran zawartość wszystkich plików regularnych, 
#które znajdują się w katalogu D i do których my (nasz skrypt) 
#mamy prawo zapisu. Kolejność, w jakiej pliki zostaną połączone, 
#jest nieistotna. W Wydruku treść każdego pliku powinna być 
#poprzedzona nagłówkiem z jego nazwą.

if [ "$#" -eq 0 ]
then
	echo "Podano zbyt mało argumentów skryptu"
	exit 1
elif [ ! -d "$1" ]
then
	echo "Argument nie jest istniejącym katalogiem"
	exit 1
fi

for f in "$1"/*
do
	if [ -f "$f" -a -w "$f" ]
	then
		echo "Nazwa pliku: $f"
		echo
		cat "$f"
		echo
		echo
	fi
done
exit 0 
