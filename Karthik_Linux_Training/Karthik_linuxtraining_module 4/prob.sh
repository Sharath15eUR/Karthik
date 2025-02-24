# to verify the command line argument input
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <inp_file>"
    exit 1
fi

INP_FILE="$1"
OUT_FILE="output.txt"

# reading line by line in the input file to extract the pattern
while IFS= read -r line; do
    FR_TIME=$(echo "$line" | grep -oP '(?<=frame.time": ")[^"]*')
    WLAN_TYPE=$(echo "$line" | grep -oP '(?<=wlan.fc.type": ")[^"]*')
    WLAN_STYP=$(echo "$line" | grep -oP '(?<=wlan.fc.subtype": ")[^"]*')

    if [[ -n "$FR_TIME" || -n "$WLAN_TYPE" || -n "$WLAN_STYP" ]]; then
        [[ -n "$FR_TIME" ]] && echo "\"frame.time\": \"$FR_TIME\"," >> "$OUT_FILE"
        [[ -n "$WLAN_TYPE" ]] && echo "\"wlan.fc.type\": \"$WLAN_TYPE\"," >> "$OUT_FILE"
        [[ -n "$WLAN_STYP" ]] && echo "\"wlan.fc.subtype\": \"$WLAN_STYP\"," >> "$OUT_FILE"
        echo >> "$OUT_FILE" 
    fi
done < "$INP_FILE"

echo "extraction completed!!! Output saved in "output.txt" YO !!!!."
