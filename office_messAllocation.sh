#!/bin/bash
for hostel in /home/HAD/*; do
  if [ -d "$hostel" ]; then
    for room in "$hostel"/*; do
      if [ -d "$room" ]; then
        for student in "$room"/*; do
          if [ -d "$student" ]; then
            messpref=$(grep "Mess Preference:" "$student/userDetails.txt" | awk '{print $NF}')
            mess=$(grep "Allocated Mess:" "$student/userDetails.txt" | awk '{print $NF}')
            if [ "$messpref" != "-" ]; then
              awk -v messpref="$messpref" '/Allocated Mess:/ {if ($3 == "-") {gsub(/[-]/, messpref, $3)} } 1' "$student/userDetails.txt" > temp.txt && mv temp.txt "$student/userDetails.txt"
            fi
          fi
        done
      fi
    done
  fi
done
