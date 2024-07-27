#!/usr/bin/env bash

echo "Content-Type: text/html"
echo ""


#muster_mail="/^[^\s@]+@[^\s@]+\.[^\s@]+$/"

min_pass_length=6

vorname=$(echo "$QUERY_STRING" | cut -d'&' -f'1' | sed "s/firstname=//g")
nachname=$(echo "$QUERY_STRING" | cut -d'&' -f'2' | sed "s/lastname=//g")
gbdate=$(echo "$QUERY_STRING" | cut -d'&' -f'3' | sed "s/gbdate=//g")
benutzername=$(echo "$QUERY_STRING" | cut -d'&' -f'4' | sed "s/username=//g")
emailAd=$(echo "$QUERY_STRING" | cut -d'&' -f'5' | sed "s/email=//g")
passwort=$(echo "$QUERY_STRING" | cut -d'&' -f'6' | sed "s/enterpass=//g")
confirmPass=$(echo "$QUERY_STRING" | cut -d'&' -f'7' | sed "s/confirmpass=//g")

status=0
if [[ $passwort != $confirmPass ]]; then
     echo "<html><body><script>alert('Passwoerter stimmen nicht ueberein');window.location.href='../register.html';</script></body></html>"
    status=1
fi

#if ! [[ $emailAd =~ $muster_mail ]]; then
 #echo "<html><body><script>alert('Ungueltige E-Mail');window.location.href='../register.html';</script></body></html>"
  #status=1
#fi


while IFS='|' read -r a b c d mail e ; do
    if test "$emailAd" == "$mail"; then
         echo "<html><body><script>alert('diese E-Mail existiert bereits');window.location.href='../register.html';</script></body></html>"
        status=1
    fi
done < kundendata.csv

if [[ $status -eq 0 ]]; then
echo "$vorname|$nachname|$gbdate|$benutzername|$emailAd|$passwort" >> kundendata.csv

echo "<html><body><script>window.location.href = '../login.html';</script></body></html>"
fi