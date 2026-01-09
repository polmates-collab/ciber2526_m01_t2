#/bin/bash


PORT=9999
VERSION_CURRENT="0.6"
IP_CLIENT="localhost"
SERVER_DIR="server"

clear

mkdir -p $SERVER_DIR

echo "Servidor de RECTP v$VERSION_CURRENT"

echo "0. Listen"

DATA=`nc -l -p $PORT`

echo "3.1 Test de datos"

HEADER=`echo $DATA | cut -d " " -f 1`

if [ "$HEADER" != "RECTP" ]
then
	echo "ERROR 1: Cabecera errónea"
	
	sleep 1
	echo "HEADER_KO" | nc $IP_CLIENT -q 0  $PORT
	exit 1
fi

VERSION=`echo $DATA | cut -d " " -f 2`

if [ "$VERSION" != "$VERSION_CURRENT" ]
then 
	echo "ERROR 2: Version errónea"
	
	sleep 1
	echo "HEADER_KO" | nc $IP_CLIENT -q 0 $PORT
exit 2
fi 

IP_CLIENT=`echo $DATA | cut -d " " -f 3`

if [ "$IP_CLIENT" == "" ]
then 
	echo "ERROR 4: IP de cliente mal fomrada"
	
	exit 4
fi 

echo "3.2. RESPONSE. Enviado HEADER_OK"

sleep 1
echo "HEADER_OK" | nc $IP_CLIENT -q 0 $PORT

echo "4. LISTEN"

DATA=`nc -l -p $PORT`

echo "8. FILE NAME"

echo "8.1 TEST "

FILE_NAME_PREFIX=`echo $DATA | cut -d " " -f 1`

if [ "$FILE_NAME_PREFIX" != "FILE_NAME" ]

then 
	echo "Error 3: Prefijo FILE_NAME incorrecto ($FILE_NAME_PREFIX)"
	
	sleep 1
	echo "FILE_NAME_KO" | nc $IP_CLIENT -q 0 $PORT
	exit 3
fi

FILE_NAME=`echo $DATA | cut -d " " -f 2`

echo "FILE NAME: $FILE_NAME"

echo "8.2 RESPONSE FILE_NAME_OK"

sleep 1
echo "FILE_NAME_OK" | nc $IP_CLIENT -q 0 $PORT

echo "9. LISTEN FILE_DATA"
echo "13. STORE FILE DATA"

nc -l -p $PORT > $SERVER_DIR/$FILE_NAME

echo "14. SEND. FILE DATA OK"

sleep 1

echo "FILE_DATA_OK" | nc $IP_CLIENT -q 0 $PORT

echo "Fin de comunicacion"

aplay $SERVER_DIR/$FILE_NAME

exit 0
