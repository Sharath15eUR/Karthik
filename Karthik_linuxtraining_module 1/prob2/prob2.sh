#cmd

#creating the file
echo HIthere > myfile2.txt
#write permission to group
chmod g+w myfile2.txt

ls -lrt

#remove write permission for group

chmod g-w myfile2.txt

ls -lrt

{ cat prob2.sh; ls -l; } > opt2.txt