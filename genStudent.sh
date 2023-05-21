#!/bin/bash
if id HAD >/dev/null 2>&1; then
  echo -n
else
  useradd -m -d /home/HAD HAD
  echo "password@123" | passwd --stdin HAD
  echo -e "Mess capacity\n1 35\n2 35\n3 35\nStudent Preferences" > /home/HAD/mess.txt
  chown HAD:HAD /home/HAD/mess.txt
fi

getent group students >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -n
else
    groupadd students
fi

getent group wardens >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -n
else
    groupadd wardens
fi

if [ $# -eq 0 ]; then
   while true; do
    read -p "Enter name: " name
    read -p "Enter roll number: " rollnumber
    read -p "Enter hostel: " hostel
    read -p "Enter room: " room
    read -p "Enter mess: " mess
    read -p "Enter mess preference: " messpref
    echo "$name $rollnumber $hostel $room $mess $messpref" >> temp.txt
   done

    file=temp.txt
else
    file=$1
    if [ ! -f "$file" ]; then
      echo "Error: $file not found"
      exit 1
    fi
fi
tail -n +2 $file | while read line; do
   name=$(echo $line | awk '{print $1}')
   rollnumber=$(echo $line | awk '{print $2}')
   hostel=$(echo $line | awk '{print $3}')
   room=$(echo $line | awk '{print $4}')
   mess=$(echo $line | awk '{print $5}')
   messpref=$(echo $line | awk '{print $6}')
   dep_num=$(echo $rollnumber | cut -c1-3)
   if [ $dep_num == '021' ]; then
      Department="Chem"
   elif [ $dep_num == '061' ]; then
      Department="CSE"
   elif [ $dep_num == '031' ]; then
      Department="Civil"
   elif [ $dep_num == '101' ]; then
      Department="ICE"
   elif [ $dep_num == '131' ]; then
      Department="EE"
   elif [ $dep_num == '141' ]; then
      Department="PROD"
   elif [ $dep_num == '181' ]; then
      Department="EC"
   elif [ $dep_num == '011' ]; then
      Department="ARCH"
   elif [ $dep_num == '121' ]; then
      Department="Mt"
   fi
   curr_year=$(date +%y)
   admit_year=$(echo $rollnumber | cut -c5-6)
   Year=$((admit_year-curr_year+2))
   if id "$hostel" >/dev/null 2>&1; then
      echo "Hostel $hostel already registered"
   else
      useradd -m -d /home/HAD/$hostel $hostel
      usermod -aG wardens $hostel
      echo "password@123" | passwd --stdin $hostel
      touch /home/HAD/$hostel/announcements.txt
      chown $hostel:$hostel /home/HAD/$hostel/announcements.txt
      touch /home/HAD/$hostel/feeDefaulters.txt
      chown $hostel:$hostel /home/HAD/$hostel/feeDefaulters.txt
      echo "alias updateDefaulter='bash /home/updateDefaulter.sh'" >> /home/HAD/$hostel/.bashrc
      source /home/HAD/$hostel/.bashrc
   fi
   room=$(printf "%03d" $room)
   room=$room
   if [ ! -d "/home/HAD/$hostel/$room" ]; then
      mkdir /home/HAD/$hostel/$room
      chown $hostel:$hostel /home/HAD/$hostel/$room
   fi
   if id "$name" >/dev/null 2>&1; then
      echo "Student $name already registered"
   else
      count=$(find /home/HAD/ -name $room  | wc -l)
      if [ "$count" -gt 2 ]; then
         echo "Error: the room $room already has more than 2 students."
      else
         useradd -m -d /home/HAD/$hostel/$room/$name $name
         echo "password@123" | passwd --stdin $name
         usermod -aG students $name
         usermod -aG $name $hostel
         echo -e "Name: $name\nRoll Number: $rollnumber\nDepartment: $Department\nYear: $Year\nHostel: $hostel\nMonth: $(date '+%B')\nAllocated Mess: $mess\nMess Preferences: $messpref " > /home/HAD/$hostel/$room/$name/userDetails.txt
         chown $name:$name /home/HAD/$hostel/$room/$name/userDetails.txt
         echo -e "TuitionFee 0\nHostelRent 0\nServiceCharge 0\nMessFee 0 " > /home/HAD/$hostel/$room/$name/fees.txt
         chown $name:$name /home/HAD/$hostel/$room/$name/fees.txt
         echo "alias messAllocation='bash /home/student_messAllocation.sh'" >> /home/HAD/$hostel/$room/$name/.bashrc
         echo "alias feeBreakup='bash /home/feeBreakup.sh'" >> /home/HAD/$hostel/$room/$name/.bashrc
         source /home/HAD/$hostel/$room/$name/.bashrc
      fi
   fi
done

chgrp wardens /home/updateDefaulter.sh
chgrp students /home/student_messAllocation.sh
chgrp HAD /home/office_messAllocation.sh
chgrp students /home/feeBreakup.sh
chmod g+x /home/updateDefaulter.sh
chmod g+x /home/student_messAllocation.sh
chmod g+x /home/office_messAllocation.sh
chmod g+x /home/feeBreakup.sh
echo "alias messAllocation='bash /home/office_messAllocation.sh'" >> /home/HAD/.bashrc
source /home/HAD/.bashrc
