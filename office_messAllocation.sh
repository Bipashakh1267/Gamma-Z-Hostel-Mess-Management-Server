#!/bin/bash
mess1=$(awk 'FNR == 2 {print $2}' /home/HAD/mess.txt)
mess2=$(awk 'FNR == 3 {print $2}' /home/HAD/mess.txt)
mess3=$(awk 'FNR == 4 {print $2}' /home/HAD/mess.txt)
tail -n +6 /home/HAD/mess.txt | while read line; do
   roll_mess=$(echo $line | awk '{print $1}')
   echo roll_mess $roll_mess
   for hostel in /home/HAD/*; do
    if [ -d "$hostel" ]; then
     for room in "$hostel"/*; do
      if [ -d "$room" ]; then
        for student in "$room"/*; do
         if [ -d "$student" ]; then
          echo $(basename $student)
          rollnumber=$(grep "Roll Number:" "$student/userDetails.txt" | awk '{print $NF}')
          echo rollnumber $rollnumber
          if [[ $roll_mess == $rollnumber ]]; then
               messpref=$(grep "Mess Preferences:" $student/userDetails.txt | awk '{print $NF}')
               echo messpref $messpref
               if [[ $messpref == 1 ]] && [[ $mess1 != 0 ]]; then
                 awk -v val="$messpref" '{ if ($1 == "Allocated") $3 = val; print }' "$student/userDetails.txt" > "$student/temp.txt" && mv "$student/temp.txt" "$student/userDetails.txt"  
                 ((mess1=mess1-1))
               elif [[ $messpref == 2 ]] && [[ $mess2 != 0 ]]; then
                 awk -v val="$messpref" '{ if ($1 == "Allocated") $3 = val; print }' "$student/userDetails.txt" > "$student/temp.txt" && mv "$student/temp.txt" "$student/userDetails.txt"  
                 ((mess2=mess2-1))
               elif [[ $messpref == 3 ]] && [[ $mess3 != 0 ]]; then
                 awk -v val="$messpref" '{ if ($1 == "Allocated") $3 = val; print }' "$student/userDetails.txt" > "$student/temp.txt" && mv "$student/temp.txt" "$student/userDetails.txt"  
                 ((mess3=mess3-1))
               fi
          fi
         fi
        done
      fi
     done
    fi
   done
done

for hostel in /home/HAD/*; do
  if [ -d "$hostel" ]; then
    for room in "$hostel"/*; do
      if [ -d "$room" ]; then
        for student in "$room"/*; do
         if [ -d "$student" ]; then
          if [[ $(sed -n '8p' "$student/userDetails.txt") == *-* ]]; then
              if [[ $mess1 != 0 ]]; then
                 messpref=1
                 awk -v val="$messpref" '{ if ($1 == "Allocated") $3 = val; print }' "$student/userDetails.txt" > "$student/temp.txt" && mv "$student/temp.txt" "$student/userDetails.txt"  
                 ((mess1=mess1-1))
               elif [[ $mess2 != 0 ]]; then
                 messpref=2
                 awk -v val="$messpref" '{ if ($1 == "Allocated") $3 = val; print }' "$student/userDetails.txt" > "$student/temp.txt" && mv "$student/temp.txt" "$student/userDetails.txt"  
                 ((mess2=mess2-1))
               elif [[ $mess3 != 0 ]]; then
                 messpref=3
                 awk -v val="$messpref" '{ if ($1 == "Allocated") $3 = val; print }' "$student/userDetails.txt" > "$student/temp.txt" && mv "$student/temp.txt" "$student/userDetails.txt"  
                 ((mess3=mess3-1))
               fi
           fi
         fi
        done
      fi
    done
  fi
done
