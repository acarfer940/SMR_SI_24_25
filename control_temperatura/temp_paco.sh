#!/bin/bash
i=0
while [ $i -ne 1 ]
do
o=0
while [ $o -ne 1000000 ]
do
((o++))
done
sensors > almacen.txt
a=$(grep Composite: almacen.txt | cut -d' ' -f5 | tr -d '+.°C')
b=$((a/10))
if [ $b -ge 40 ]
then
echo "Su cpu esta a +40ºC"
echo -e "Subject: su cpu esta a +40ºC \n\nEste es un correo enviado desde msmtp en un solo comando." | msmtp --host=192.168.1.10 --port=1025 --from=paco@paco.com destinatario@example.com 
((i++))
fi
rm -rf almacen.txt
done
