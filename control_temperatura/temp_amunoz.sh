#!/bin/bash

read -p "Introduzca el limite de temperatura deseado: " limite

TEMP_LIMITE=$limite

echo "Inicio de la medición de la temperatura de la CPU: $(date)"

while true; do
    sensors > temp.txt
    TEMP=$(grep Composite: temp.txt | cut -d' ' -f5 | tr -d '+°C')

    echo "Temperatura actual: $TEMP °C"

    if (( $(echo "$TEMP > $TEMP_LIMITE" | bc -l ) )); then
        echo "La temperatura de la CPU es crítica $TEMP °C y sobrepasa el límite $TEMP_LIMITE °C."
	echo -e "Subject: Temperatura de la CPU por encima de los limites\n\nLa Temperatura de tu CPU es demasiado alta ($TEMP), haga que baje o su ordenador se apagara automaticamente" | msmtp --host=192.168.1.10 --port=1025 --from=adrian@muñoz.com destinatario@example.com
    fi

    sleep 10
done
