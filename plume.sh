continuer=true
envoyerReponse () {
	if test $1 != "exit"
	then
		echo "(/HTTP/1.0,200,\"OK\")"
		echo "reçu";
	fi
} 

verifChaine () {
	echo $@ | egrep "^GET .* HTTP/1.0$"
}

messageErreur () {
	if test $1 != "exit"
	then
		echo "ERREUR !"
	fi
}

sortir () {
	if test $1 = "exit"
	then
		echo "ON SORT !!!"
		#continuer=false
		exit
	fi
}

afficherContenu () {
	if test $1 != "exit"
	then
		echo $1
	fi
}

while $continuer
do
	read chaineRecu
	chaine=$(echo $chaineRecu | cut -d' ' -f2)
	envoyerReponse $chaine
	verifChaine $chaineRecu || messageErreur $chaine
	sortir $chaine
	afficherContenu $chaine
done



