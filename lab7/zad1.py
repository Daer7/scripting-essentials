#!/usr/bin/python3

# Dane jest drzewo katalogowe D i dwa pliki zwykłe P1 i P2 (argumenty skryptu).
# 1. W D dla każdego linku symbolicznego należy wyświetlić jego nazwę (ostatni człon) oraz liczbę znaków jaka jest w nim (linku)
# zapisana, zaś dla każdego pliku zwykłego należy wyświetlić jego nazwę (ostatni człon) oraz
# liczbę linii tego pliku zawierających napis "hello". (3 pt)
# 2. Wyniki z punktu 1 należy dodatkowo zapisać do P1 po czym posortować (przed wyświetleniem) wg nazwy pliku. (2 pt)
# 3. Należy wypisać na ekran zawartość pliku P2 z wszystkimi datami postaci YYYY-MM-DD zamienionymi na postać MM.DD.YY.
# Daty są zawsze oddzielone co najmniej jednym znakiem (ale niekoniecznie spacją). Może być więcej niż jedna data w jednej linii. (4 pt)

import os
import re
import sys

if sys.argv.__len__() < 4:
    print("Podano zbyt mało argumentów skryptu")
    sys.exit(1)
elif not os.path.isdir(sys.argv[1]):
    print("Pierwszy argument powinien być istniejącym drzewem katalogowym")
    sys.exit(2)
elif not os.path.isfile(sys.argv[2]) or not os.path.isfile(sys.argv[3]):
    print("Drugi i trzeci argument powinny być istniejącymi plikami zwykłymi")
    sys.exit(3)

D = sys.argv[1]
P1 = sys.argv[2]
P2 = sys.argv[3]

# Z1 i Z2

with open(P1, 'w') as fp1:
    for root, dirs, files in os.walk(D):
        for direntry in os.scandir(root):
            if direntry.is_symlink():  # scandir tu użyty, bo linijka true nawet jeśli cel jest zepsuty (inaczej niż os.path.islink() )
                name = os.path.basename(direntry.path)
                number_of_chars = len(os.readlink(direntry.path))
                str1 = "{} : {}\n".format(name, number_of_chars)
                print(str1, end='')
                fp1.write(str1)
            elif direntry.is_file(follow_symlinks=False):
                name = os.path.basename(direntry.path)
                lines_with_hello = 0
                with open(direntry.path, 'r') as f:
                    for line in f:
                        if "hello" in line:
                            lines_with_hello += 1
                str2 = "{} : {}\n".format(name, lines_with_hello)
                print(str2, end='')
                fp1.write(str2)

with open(P1, 'r') as fp1:
    for lineentry in sorted(fp1):  # sortowanie do celow wyswietlenia
        print(lineentry, end='')

# Z3

pttrn = re.compile(r'\d\d(\d\d)-(\d\d)-(\d\d)(.|\n)')
with open(P2, 'r') as fp2:
    for l in fp2:
        if l[-1] != '\n':  # na wypadek jesli wczytana linia nie konczy sie znakiem nowej linii
            l += '\n'
        linechanged = pttrn.sub(r'\2.\3.\1\4', l)
        print(linechanged, end='')
