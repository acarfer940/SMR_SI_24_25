#!/bin/bash

temperatura=$(sensors | grep -i 'Composite' | awk '{print $2}' | sed -E 's/[^0-9]//g')
if [ "$temperatura" -gt 30 ]
        then
                sensors
                echo -e "Subject: Hola,\n\nHay un problema con la temperatura de este equipo" | msmtp --host=192.168.1.10 --port=1025 --from=malaver@maria.com maestro@example.com
                echo "Se ha enviado un email, por que la temperatura del equipo es superior."
        else
                echo "El equipo esta perfecatamente"
        fi
