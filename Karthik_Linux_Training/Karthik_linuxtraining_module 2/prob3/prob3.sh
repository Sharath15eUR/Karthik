#cmd

#created a log file manually prior to the task

grep "ERROR" logs.txt | grep -v "DEBUG" > filtered_logs.txt
