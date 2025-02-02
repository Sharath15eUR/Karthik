#!/bin/bash

# File to log the errors on execution of the script
ERROR_LOG="errors.log"

# Recursive function to search for a keyword in a directory and its subdirectories

search_directory_method() {
    local dir=$1
    local key=$2
    for file in "$dir"/*; do
        if [[ -d "$file" ]]; then
            search_directory_method "$file" "$key"  # Corrected function call
        elif [[ -f "$file" ]]; then
            if grep -q "$key" "$file"; then
                echo "Found '$key' in: $file"
            fi
        fi
    done
}

# Function to display the help menu to the user

display_help_method() {
    cat << EOF
Usage: $0 [OPTIONS]

Options:
  -d <directory>   to search for a keyword recursively in the specified directory
  -k <keyword>     to search for a keyword
  -f <file>        to search for a keyword in a specified file
  --help           to display the help menu to the user

Example Usage:
  ./file_analyzer.sh -d logs -k error
  ./file_analyzer.sh -f script.sh -k TODO
  ./file_analyzer.sh --help
EOF
}

# Function to log the errors during the execution

log_error_method() {
    echo "$1" | tee -a "$ERROR_LOG"
}

# Function to validate the inputs

validate_inputs_method() {
    local file=$1
    local key=$2
    if [[ ! -e "$file" ]]; then
        log_error_method "Error: File '$file' does not exist!"
        exit 1
    fi
    if [[ -z "$key" ]]; then
        log_error_method "Error: Keyword cannot be empty."
        exit 1
    fi
}

# Parse command line arguments using getopts

while getopts ":d:k:f:-:" opt; do
    case $opt in
        d) dir=$OPTARG ;;
        k) key=$OPTARG ;;
        f) file=$OPTARG ;;
        -) case $OPTARG in
               help) display_help_method; exit 0 ;;  # Corrected function call
               *) log_error_method "NOO!!! Invalid option --$OPTARG"; exit 1 ;;
           esac ;;
        \?) log_error_method "NOO!!! Invalid option: -$OPTARG"; exit 1 ;;
        :) log_error_method "YO!!! Option -$OPTARG requires an argument."; exit 1 ;;
    esac
done

# execute tasks based on the parsed arguments

if [[ -n "$dir" && -n "$key" ]]; then
    if [[ ! -d "$dir" ]]; then
        log_error_method "Error: Oh nooo!! directory '$dir' does not exist!!!"
        exit 1
    fi
    echo "YO!!!!!! Searching directory '$dir' for keyword '$key'..."
    search_directory_method "$dir" "$key"  # Function call
elif [[ -n "$file" && -n "$key" ]]; then
    validate_inputs_method "$file" "$key"  # Function call
    echo "YO!!!!!! Searching for '$key' in file '$file'..."
    grep --color=always "$key" <<< "$(cat "$file")" || echo "Oh nooo!!! Keyword '$key' not found in '$file'."
else
    log_error_method "Error: Invalid usage. Use --help for execution usage info!!!!!!!"
    exit 1
fi

# capture the exit status

exit_status=$?
echo "Exit Status: $exit_status"
exit $exit_status

