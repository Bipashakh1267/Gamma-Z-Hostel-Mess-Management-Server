tail -n +2 /home/studentDetails.txt | while read line; do
   name=$(echo $line | awk '{print $1}')
   hostel=$(echo $line | awk '{print $3}')
   userdel $name
   userdel $hostel
   groupdel studentOf$hostel
done
rm -rf /home/HAD 
