#!/bin/bash
apt-get install -qq -y acl >/dev/null 2>&1
setfacl -m g:students:rw /home/HAD/mess.txt
for hostel in /home/HAD/*;do
  if [ -d "$hostel" ]; then
      chmod -R g+rwx /home/HAD/$(basename $hostel)
      chgrp -R HAD $(basename $hostel)
      chmod -R o-rw /home/HAD/$(basename $hostel)
  for room in $hostel/*; do
      if [ -d "$room" ]; then
       chmod -R g+rwx $room
       chgrp -R $(basename $hostel) $room
       setfacl -m g:students:rw $hostel/announcements.txt
       setfacl -m g:students:rw $hostel/feeDefaulters.txt
      fi
     done
  fi
done


