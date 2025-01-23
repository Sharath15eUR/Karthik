#cmd

#creating the directories

mkdir -p dir1/dir2

echo "hi THERE FOLK!!!" > dir1/dir2/myfile3.txt

cd dir1

ln -s dir2/myfile3.txt file_link

echo "Soft link : " > ../opt3.txt

{ cat ../prob3.sh; ls -l; } > ../opt3.txt