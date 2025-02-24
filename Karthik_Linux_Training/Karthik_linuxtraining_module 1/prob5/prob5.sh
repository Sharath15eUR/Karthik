#cmd

mkdir dir1

cd dir1

echo "HI there buddy!!" > myfile1.txt
echo "YO yo buddy!!" > myfile2.txt
echo "Lets go!!!" > myfile3.txt

ls -lt > timestamp1.txt
ls -lrt > timestamp2.txt

(cat ../prob5.sh; ls -lt; ls -lrt) > opt4.txt