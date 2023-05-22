#!/bin/bash
apt-get install -qq -y acl >/dev/null 2>&1
chmod 755 HAD
setfacl -m g:students:rw /home/HAD/mess.txt
for hostel in /home/HAD/*;do
   echo hostel $hostel
  if [ -d "$hostel" ]; then
      echo dir_hostel $hostel
      chmod  755 $hostel
    for room in $hostel/*; do
      echo room $room
      if [ -d "$room" ]; then
       echo dir_room $room
       chmod 755 $room
       for student in $room/*; do
              echo student $student
              chmod 755 $student
              for student in $student/*; do
                chgrp $(basename $hostel) *
                chmod 750 *
              done
            done
      fi
      setfacl -m g:students:rw $hostel/announcements.txt
      setfacl -m g:students:rw $hostel/feeDefaulters.txt
    done
  fi
done
