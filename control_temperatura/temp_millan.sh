#!/bin/bash
sensors > millan.txt
o=0
while [ $o -ne 1 ]
do
n=$(grep Composite: millan.txt | cut -d' ' -f5 | tr -d '+.°C')
s=$((n/10))
if [ $s -gt 30 ]
then
echo "La cpu esta pasando los limites establecidos"
echo -e "Subject : La cpu esta pasando los limites establecidos s " | msmtp --host=192.168.1.10 --port=1025 --from=javier@millan.com destinatario@example.com
fi
sleep 15
done

