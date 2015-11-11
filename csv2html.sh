#!/bin/bash

DELIM=';'
NUMCOL="0";

function readCsv () {
	cat | while IFS=$'\n' read -a Array
	do 
		echo "${Array[@]}"
	done
}

#On récupère le nom des colonnes
read HEAD;

#On vérifie les différentes options
for i in $@
do
	case ${i} in
		-d?)					#Option pour le délimiteur
			DELIM=${i:2};
		;;
		-s*)					#Option pour le tri par numero de colonne
			NUMCOL=${i:2};
		;;
		-S*)					#Option pour le tri par nom de colonne
			NUMCOL=$(echo $HEAD | tr ";" $"\n" | grep ${i:2} -n | cut -d: -f1)
		;;
	esac
done

#Affichage de l'entete
echo "<table>";
echo -e "\t<tr>"
echo -e "\t\t<th>$HEAD</th>" | sed "s/$DELIM/<\/th><th>/g";
echo -e "\t</tr>";

#Si un trie est spécifié sur une colonne, alors on effectue ce trie, sinon on affiche le tableau sans le trier
if [ $NUMCOL -ne 0 ]
then
	readCsv | sort -t';' -k$NUMCOL | sed -r -s "s/(.*)/\t<tr>\n\t\t<td>\1<\/td>\n\t<\/tr>/g" | sed "s/$DELIM/<\/td><td>/g"
	
else
	readCsv | sed -r -s "s/(.*)/\t<tr>\n\t\t<td>\1<\/td>\n\t<\/tr>/g" | sed "s/$DELIM/<\/td><td>/g"
fi

echo "</table>";
IFS=' ';
