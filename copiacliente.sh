#!/bin/bash

AUDIO_FILE="audio.wav"

PORT=9999

IP_SERVER="localhost"

VERSION_CURRENT="0.5"

echo "Cliente del protocolo RECTP v$VERSION_CURRENT"

echo "1. SEND. Enviamos la cabecera al servidor"

echo "RECTP $VERSION_CURRENT" | nc $IP_SERVER -q 0 $PORT 

RESPONSE=`nc -l -p  $PORT`

echo "5. TEST. Header"

if [ "$RESPONSE" != "HEADER_OK" ]

then

echo "Error 1: Cabeceras mal formadas"

exit 1

fi 

echo "6. SEND. Nombre de archivo"


