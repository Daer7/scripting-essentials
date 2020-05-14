#!/usr/bin/python3

# Dane są katalogi K1, K2 oraz T (argumenty skryptu). K1 i K2 są rozumiane jako katalogi „jednopoziomowe”
# (tzn. interesują nas tylko pliki bezpośrednio w tym katalogu, a nie głębiej), zaś T jest rozumiane jako
# całe drzewo katalogowe (dowolnej głębokości). Należy:
# 1. Utworzyć w K2 kopie plików regularnych z K1, do których my (wykonawca skryptu) mamy prawo wykonania. (3)
# 2. W K1 przekształcić wszystkie linki symboliczne do katalogów tak, aby były zdefiniowane ścieżką bezwzględną. (3)
# 3. W T należy znaleźć (wypisać nazwy) katalogi, które zostały utworzone dawniej niż 5 minut temu i które mają
# co najwyżej 3 (bezpośrednie) podkatalogi. (4)

import os
import sys
import time
from shutil import copy

if sys.argv.__len__() < 4:
    print("Podano zbyt mało argumentów skryptu")
    sys.exit(1)
elif not os.path.isdir(sys.argv[1]) or not os.path.isdir(sys.argv[2]) or not os.path.isdir(sys.argv[3]):
    print("Wszystkie argumenty skryptu powinny być istniejącymi katalogami")
    sys.exit(2)

K1 = sys.argv[1]
K2 = sys.argv[2]
T = sys.argv[3]

# Z1
for filename in os.scandir(K1):
    if filename.is_file(follow_symlinks=False) and os.access(filename.path, os.X_OK, follow_symlinks=False):
        copy(filename.path, K2)

# Z2
for filename in os.scandir(K1):
    if filename.is_symlink() and filename.is_dir():
        # bezwzgledna sciezka do celu
        abspath = os.path.realpath(filename.path)
        os.unlink(filename.path)  # usun poprzedni symlink
        os.symlink(abspath, filename.path)  # symlink do sciezki bezwzglednej

# Z3
for root, dirs, files in os.walk(T):
    direct_subdirs = 0
    for dir in dirs:
        # nie zliczamy symlinkow na katalogi
        if not os.path.islink(os.path.join(root, dir)):
            direct_subdirs += 1
    if direct_subdirs > 3:
        continue

    # roznica aktualnego czasu i czasu ostatniej modyfikacji katalogu [s]
    if(time.time() - os.stat(root).st_mtime > 300):
        print(root)
