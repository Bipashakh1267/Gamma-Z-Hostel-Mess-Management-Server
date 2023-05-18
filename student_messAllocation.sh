#!/bin/bash
messpref=$(grep "Mess Preference:" $HOME/userDetails.txt | awk '{print $NF}')
rollnumber=$(grep "Roll Number:" $HOME/userDetails.txt | awk '{print $NF}')
if [ "$messpref" = "-" ]; then
    read "Enter your mess Preference :- " messpref
    awk -v messpref="$messpref" '/Mess Preference:/ {if ($3 == "-") {gsub(/[-]/, messpref, $3)} } 1' $HOME/userDetails.txt > temp.txt && mv temp.txt $HOME/userDetails.txt
    echo $rollnumber >> /home/HAD/mess.txt
else
    echo $rollnumber >> /home/HAD/mess.txt
fi
