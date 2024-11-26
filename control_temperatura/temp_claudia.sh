#!/bin/bash
DESTINATARIO="antonio@example.com"
obtener_temperatura() {
    temperatura=$(sensors | grep -i 'Composite' | cut -d ' ' -f5 | cut -d "+" -f2 | cut -d "." -f1)
    echo $temperatura
}
enviar_email() {
    echo -e "Subject: Alerta de temperatura alta\n\nLa temperatura actual es de $1°C" | msmtp --host=192.168.1.10 --port=1025 --from=cgonde15@iessalmedina.es $DESTINATARIO
}
temperatura_actual=$(obtener_temperatura)
if [ "$temperatura_actual" -gt 38 ]
then
    echo "La temperatura ha superado el umbral. Enviando un correo..."
    enviar_email $temperatura_actual
else
    echo "La temperatura está por debajo del umbral: $temperatura_actual °C"
fi
