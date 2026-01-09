#!/bin/bashi

echo"¿Cuantos ping quieres hacer a google?"

read NUM

# Comparamos el numero entre comillas para asegurar
# que no introducen un intro (variable vacia)


if [  "$NUM" == "" ]
then
	echo "Inserta un numero valido"
	exit 1
fi

ping -c $NUM google.com

exit 0

