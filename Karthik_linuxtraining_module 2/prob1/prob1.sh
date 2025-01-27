#cmd

#list of files with size greater than 1 MB

find . -type f -size +1M -exec ls -lh {} + | awk '{print $9, $5}' > opt1.txt
