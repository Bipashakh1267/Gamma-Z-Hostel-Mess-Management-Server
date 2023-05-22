tail -n +2 /home/studentDetails.txt | while read line; do
   name=$(echo $line | awk '{print $1}')
   userdel $name
   groupdel $name
done

groupdel students
userdel HAD
rm -rf /home/HAD 
tail -n +2 /home/studentDetails.txt | while read line; do
   hostel=$(echo $line | awk '{print $3}')
   userdel $hostel
   groupdel -f $hostel
done

tail -n +2 /home/studentDetails.txt | while read line; do
   hostel=$(echo $line | awk '{print $3}')
   groupdel -f studentsOf$hostel
done
