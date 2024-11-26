#!/bin/bash

# ========== CONFIGURACIÓN ===================
TEMP_LIMITE=40
CORREO_DESTINATARIO="acarfer940@iessalmedina.es"
CORREO_EMISOR="alertas@iessalmedina.es"
ASUNTO="Alerta: Temperatura Alta del Sistema"
CUERPO="La temperatura del sistema ha superado el límite de $TEMP_LIMITE°C."
# ========== CONFIGURACIÓN ===================


verificar_comando() {
  local comando=$1
  if ! command -v "$comando" &> /dev/null; then
    echo "El comando '$comando' no está instalado. Por favor, instálalo."
    exit 1
  fi
}

verificar_comando "sensors"
verificar_comando "msmtp"

while true; do

  TEMPERATURA=$(sensors | grep 'Composite:' | awk '{print $2}' | tr -d '+°C')
  echo -ne "\rTemperatura actual: $TEMPERATURA°C"
  TEMPERATURA=$(echo "$TEMPERATURA" | cut -d'.' -f1)

  if [ "$TEMPERATURA" -ge "$TEMP_LIMITE" ]; then
    echo -e "Subject: $ASUNTO\n\n$CUERPO" | msmtp --host=192.168.1.10 --port=1025 --from=$CORREO_EMISOR $CORREO_DESTINATARIO  
    echo -e "\nLa he alcanzado"
    echo "Temperatura límite superada. Deteniendo el script."
    exit 0
  fi

  sleep 1
done
