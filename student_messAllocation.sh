#!/bin/bash
rollnumber=$(grep "Roll Number:" $HOME/userDetails.txt | awk '{print $NF}')
if [[ $(sed -n '8p' $HOME/userDetails.txt) == *-* ]]; then
    read -p "Enter your mess Preference :- " messpref
    awk -v val="$messpref" '{ if ($1 == "Mess") $3 = val; print }' "$HOME/userDetails.txt" > "$HOME/temp.txt" && mv "$HOME/temp.txt" "$HOME/userDetails.txt" 
    echo $rollnumber >> /home/HAD/mess.txt
else
    echo $rollnumber >> /home/HAD/mess.txt
fi
