#!/bin/bash
echo "alias genStudent='bash /home/getStudent.sh'" >> /root/.bashrc
echo "alias permit='bash /home/permit.sh'" >> /root/.bashrc
echo "alias messAllocation='bash /home/office_messAllocation.sh'" >> /home/HAD/.bashrc
source /root/.bashrc
for hostel in /home/HAD/*; do
  if [ -d "$hostel" ]; then
  chown $(basename $hostel):$(basename $hostel) /home/updateDefaulter.sh
  echo "alias updateDefaulter='bash /home/updateDefaulter.sh'" >> $hostel/.bashrc
  source $hostel/.bashrc
    for room in "$hostel"/*; do
      if [ -d "$room" ]; then
        for student in "$room"/*; do
          if [ -d "$student" ]; then
             chown $(basename $student):$(basename $student) /home/student_messAllocation.sh
             echo "alias messAllocation='bash /home/student_messAllocation.sh'" >> $student/.bashrc
             echo "alias feeBreakup='bash /home/feeBreakup.sh'" >> $student/.bashrc
             source $student/.bashrc
          fi
        done
      fi
    done
  fi
done
