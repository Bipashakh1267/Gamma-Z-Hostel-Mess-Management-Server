#!/bin/bash
for room in $HOME/*; do
  if [ -d $room ]; then
    for student in $room/*; do
      if [ -d $student ]; then
        if [ $(awk 'NR==2 {print $2}' $student/fees.txt) -eq 0 ];then
          if ! grep -q "$(awk -F ': ' '/Roll Number:/ {print $2}' $student/userDetails.txt)" "$HOME/feeDefaulters.txt"; then
                rollnumber=$(awk -F ': ' '/Roll Number:/ {print $2}' $student/userDetails.txt)
                echo $(basename $student) $rollnumber >> $HOME/feeDefaulters.txt
          fi
        fi
      fi
    done
  fi
done
