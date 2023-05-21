#!/bin/bash
for hostel in /home/HAD/*; do
  if [ -d "$hostel" ]; then
    for room in "$hostel"/*; do
      if [ -d "$room" ]; then
        for student in "$room"/*; do
         if [ -d "$student" ]; then
          if [[ $(sed -n '8p' $student/userDetails.txt) != *-* ]]; then
            messpref=$(grep "Mess Preference:" "$student/userDetails.txt" | awk '{print $NF}')
            awk -v val="$messpref" '{ if ($1 == "Allocated") $3 = val; print }' "$student/userDetails.txt" > "$student/temp.txt" && mv "$student/temp.txt" "$student/userDetails.txt"  
          fi
         fi
        done
      fi
    done
  fi
done
