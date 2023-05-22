#!/bin/bash
chmod 755 /home/HAD
chmod 766 /home/HAD/mess.txt
for hostel in /home/HAD/*;do
   echo hostel $hostel
  if [ -d "$hostel" ]; then
    echo studentsOf$(basename $hostel)
    groupadd studentsOf$(basename $hostel)
    echo dir_hostel $hostel
    chmod 755 $hostel
    usermod -aG $(basename $hostel) HAD
    for room in $hostel/*; do
      echo room $room
      if [ -d "$room" ]; then
       echo dir_room $room
       chmod 755 $room
       chgrp studentsOf$(basename $hostel) $hostel/announcements.txt
       chmod 660 $hostel/announcements.txt
       chgrp studentsOf$(basename $hostel) $hostel/feeDefaulters.txt
       chmod o-r $hostel/feeDefaulters.txt
       for student in $room/*; do
            echo student $student
            chmod 755 $student
            usermod -aG studentsOf$(basename $hostel) $(basename $student) 
            usermod -aG $(basename $student) $(basename $hostel)
            usermod -aG $(basename $student) HAD
            chmod 751 $student/*
          done
      fi
    done
  fi
done
usermod -aG wheel HAD
