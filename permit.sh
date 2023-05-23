#!/bin/bash
chmod 755 /home/HAD
chmod 766 /home/HAD/mess.txt
for hostel in /home/HAD/*;do
  if [ -d "$hostel" ]; then
    groupadd studentsOf$(basename $hostel)
    chmod 755 $hostel
    usermod -aG $(basename $hostel) HAD
    for room in $hostel/*; do
      if [ -d "$room" ]; then
       chmod 755 $room
       chgrp studentsOf$(basename $hostel) $hostel/announcements.txt
       chmod 660 $hostel/announcements.txt
       chgrp studentsOf$(basename $hostel) $hostel/feeDefaulters.txt
       chmod o-r $hostel/feeDefaulters.txt
       for student in $room/*; do
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
