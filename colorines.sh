#!/bin/bash

FIRST=0
LAST=7

for NUM in `seq $FIRST $LAST`
do
	echo -e "\033[37;3${NUM}mHola a todo el mundo!\033[0m"
done
