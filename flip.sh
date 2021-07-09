#!/bin/bash -x
x=$((RANDOM%2))
IF [ $x -eq 0 ]
then
echo tail
else
echo head
fi
