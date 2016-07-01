#!/bin/bash

wget http://slovnik.zcu.cz/files/slovnik_data.md5 -O slovnik.md5
test -f slovnik.txt || wget http://slovnik.zcu.cz/files/slovnik_data.txt -O slovnik.txt
test "$(cut -d ' ' -f 1 slovnik.md5)" = "$(md5sum slovnik.txt|cut -d ' ' -f 1)" || wget http://slovnik.zcu.cz/files/slovnik_data.txt -O slovnik.txt
rm -f slovnik.md5
rm -f ~/.slovnikdb_{a,b}
echo "Converting..."
mkdir -p share/slovnik/
cat slovnik.txt |grep -v '#' --binary-files=text | cut -f 1,2 -s| iconv -f ISO88592 -t ASCII//TRANSLIT | tr '[:upper:]' '[:lower:]' | LC_ALL=C awk -F '\t' '{print $1 "\t" $2}' | LC_ALL=C sort > share/slovnik/slovnik.txt
