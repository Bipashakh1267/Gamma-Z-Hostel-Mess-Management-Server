#!/bin/bash
awk '/TuitionFee/ {$2=$2+50000; print}' $HOME/fees.txt > temp.txt && mv temp.txt $HOME/fees.txt
awk '/HostelRent/ {$2=$2+20000; print}' $HOME/fees.txt > temp.txt && mv temp.txt $HOME/fees.txt
awk '/ServiceCharge/ {$2=$2+10000; print}' $HOME/fees.txt > temp.txt && mv temp.txt $HOME/fees.txt
awk '/MessFee/ {$2=$2+20000; print}' $HOME/fees.txt > temp.txt && mv temp.txt $HOME/fees.txt

echo "Date of fee submission :- $date" >> $HOME/fees.txt
hostel=$(direname $(dirname $HOME))
if [ $(cat $hostel/announcements.txt | wc -l) -lt 5 ]
then
    echo "$(awk -F ': ' '/Roll Number:/ {print $2}' $HOME/userDetails.txt)" >> $hostel/announcements.txt
fi
echo "Fee successfully submitted"

