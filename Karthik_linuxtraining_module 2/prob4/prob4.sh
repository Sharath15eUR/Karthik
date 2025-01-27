#cmd


#to fetch the details of the most memory consuming process and terminate it

highest_memproc=$(ps -eo pid,%mem --sort=-%mem | awk 'NR==2 {print $1}')
kill -9  "$highest_memproc"

echo "highest memory consuming pr$highest_memproc is killed YO!!!!" > opt4.txt
