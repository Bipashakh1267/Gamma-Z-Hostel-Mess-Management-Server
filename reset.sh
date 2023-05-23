#!/bin/bash
tail -n +2 /home/studentDetails.txt | while read line; do
   name=$(echo $line | awk '{print $1}')
   userdel -rf $name
   groupdel -f $name
done

groupdel students
userdel -rf HAD
rm -rf /home/HAD 
tail -n +2 /home/studentDetails.txt | while read line; do
   hostel=$(echo $line | awk '{print $3}')
   userdel -rf $hostel
   groupdel -f $hostel
done

tail -n +2 /home/studentDetails.txt | while read line; do
   hostel=$(echo $line | awk '{print $3}')
   groupdel -f studentsOf$hostel
done
