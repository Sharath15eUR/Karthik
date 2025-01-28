#!/bin/bash

#-------------------------------------------
#PART-1 = command-line arguments and quoting
#-------------------------------------------

# verifying the script's call with exactly three arguments

if [[ $# -ne 3 ]]; then
  echo "call format should be : $0 <source_dir> <backup_dir> <file_type>"
  exit 1
fi

SRC_DIR="$1"
BKP_DIR="$2"
FLE_TYP="$3"

echo "source directory: $SRC_DIR" 
echo "backup directory: $BKP_DIR" 
echo "file -------type: $FLE_TYP"

#-------------------------------------------
#PART-2 = globbing
#-------------------------------------------

FILES_FOR_BACKUP=("$SRC_DIR"/*"$FLE_TYP")

# "*" =  all files with the desired extension are taken

if [[ ${#FILES_FOR_BACKUP[@]} -eq 0 ]]; then
    echo "no files with the given extension in the source directory yo !!!!!!!!"
    exit 1
fi

echo "files to be backed up yo..." 

for file in "${FILES_FOR_BACKUP[@]}"; do
    echo "$file"
done

#-------------------------------------------
#PART-3 = export statement
#-------------------------------------------

export BKP_CNT=0

#-------------------------------------------
#PART-4 = conditional ops and array ops
#-------------------------------------------

# creating the backup directory if it doesn't exist
if [[ ! -d "$BKP_DIR" ]]; then
  mkdir -p "$BKP_DIR" || { echo "failed creating backup directory yo !!!!!!!!!"; exit 1; }
fi

# total backup size
BKD_UP_SIZE=0

echo "Backing up files yo..." 

for file in "${FILES_FOR_BACKUP[@]}"; do
  DST_FLE="$BKP_DIR/$(basename "$file")"

  if [[ ! -e "$DST_FLE" || "$file" -nt "$DST_FLE" ]]; then
    cp "$file" "$DST_FLE"
    ((BKP_CNT++))
    FILE_SIZE=$(stat -c%s "$file")
    ((BKD_UP_SIZE += FILE_SIZE))
    echo "Backed up: $file ($FILE_SIZE bytes)"
  else
    echo "Skipped: $file (yo... already file is present overwriting if the contents differ!!!)"
  fi
done

#-------------------------------------------
#PART-5 = output report summary generation
#-------------------------------------------

BACKUP_REPORT_FILE="$BKP_DIR/backup_report.log"
{
  echo "Backup Summary Report"
  echo "*-*-*-*-*-*-*-*-*-*-*"
  echo "Total Files Processed: $BKP_CNT"
  echo "Total Size of Backed Up Files: $BKD_UP_SIZE bytes"
  echo "Backup Directory: $BKP_DIR"
  echo "*-*-*-*-*-*-*-*-*-*-*"
} > "$BACKUP_REPORT_FILE"

echo "Backup completed. Report saved to $BACKUP_REPORT_FILE."

