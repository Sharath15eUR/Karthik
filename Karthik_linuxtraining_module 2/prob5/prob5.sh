#cmd

#using netstat command 

(netstat -rn | grep 'UG' | awk '{print}' | sort -u;
echo "only gateway!!!";
netstat -rn | grep 'UG' | awk '{print $2}' |sort -u;) > opt5.txt
