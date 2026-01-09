#/bin/bash


PORT=9999
VERSION_CURRENT="0.5"
IP_CLIENT="localhost"


echo "Servidor de RECTP v$VERSION_CURRENT"

echo "0. Listen"

DATA=`nc -l -p $PORT`

echo "3.1 Test de datos"

HEADER=`echo $DATA | cut -d " " -f 1`

if [ "$HEADER" != "RECTP" ]
then
	echo "ERROR 1: Cabecera errónea"
	
	echo "HEADER_KO" | nc $IP_CLIENT -q 0  $PORT
	
	exit 1
fi

VERSION=`echo $DATA | cut -d " " -f 2`

if [ "$VERSION" != "$VERSION_CURRENT" ]
then 
	echo "ERROR 2: Version errónea"
	
	echo "HEADER_KO" | nc $IP_CLIENT -q 0 $PORT

exit 2
fi 

echo "3.2. RESPONSE. Enviado HEADER_OK"

 echo "HEADER_OK" | nc $IP_CLIENT -q 0 $PORT

echo "4. LISTEN"

DATA=`nc -l -p $PORT`
