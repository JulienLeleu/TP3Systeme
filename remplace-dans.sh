#!/bin/bash

corps=$(cat -u $1);

cat | sed -e "/^--DEBUT_REMPLACEMENT--$/i$(echo $corps)" -e "/^--DEBUT_REMPLACEMENT--$/,/^--FIN_REMPLACEMENT--$/d";

#2e solution
#cat | sed "/--DEBUT_REMPLACEMENT--/,/--FIN_REMPLACEMENT--/ s/.*/$corps/" | uniq;
