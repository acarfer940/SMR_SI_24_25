#!/bin/bash

n=0

while [ $n -ne 1 ]
do
	sensors > temperatura.txt
	a=$(grep Composite: temperatura.txt | cut -d' ' -f5 | tr -d '+.°C')
	b=$((a/10))
		if [ $b -le 80 ]
			then
				echo "Su cpu esta a +$bºC"
			else
				echo "Su ordenador esta a punto de explotar"
				echo -e "Subject: Test Email\n\nEste es un correo enviado desde msmtp en un solo comando." | msmtp --host=192.168.1.10 --port=1025 --from=abencar09@iessalmedina.com maestro@iesalmednia.com
				((n++))
		fi
	rm -rf temperatura.txt
	sleep 3
done
