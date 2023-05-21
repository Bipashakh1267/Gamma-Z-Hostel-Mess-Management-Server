#!/bin/bash
echo "alias permit='bash /home/permit.sh'" >> /root/.bashrc
source /root/.bashrc
chgrp wardens /home/updateDefaulter.sh
chgrp students /home/student_messAllocation.sh
chgrp HAD /home/office_messAllocation.sh
chgrp students /home/feeBreakup.sh
chmod g+x /home/updateDefaulter.sh
chmod g+x /home/student_messAllocation.sh
chmod g+x /home/office_messAllocation.sh
chmod g+x /home/feeBreakup.sh
echo "alias messAllocation='bash /home/office_messAllocation.sh'" >> /home/HAD/.bashrc
for hostel in /home/HAD/*; do
  if [ -d "$hostel" ]; then
  echo "alias updateDefaulter='bash /home/updateDefaulter.sh'" >> $hostel/.bashrc
  source $hostel/.bashrc
    for room in "$hostel"/*; do
      if [ -d "$room" ]; then
        for student in "$room"/*; do
          if [ -d "$student" ]; then
             echo "alias messAllocation='bash /home/student_messAllocation.sh'" >> $student/.bashrc
             echo "alias feeBreakup='bash /home/feeBreakup.sh'" >> $student/.bashrc
             source $student/.bashrc
          fi
        done
      fi
    done
  fi
done
