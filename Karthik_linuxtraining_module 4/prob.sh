# Ensure the script is executed with an input file argument
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="output.txt"

# Ensure the input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Error: Input file '$INPUT_FILE' not found."
    exit 1
fi

# Clear previous output file if exists
> "$OUTPUT_FILE"

# Read the input file line by line
while IFS= read -r line; do
    # Extract values using grep
    FRAME_TIME=$(echo "$line" | grep -oP '(?<=frame.time": ")[^"]*')
    WLAN_FC_TYPE=$(echo "$line" | grep -oP '(?<=wlan.fc.type": ")[^"]*')
    WLAN_FC_SUBTYPE=$(echo "$line" | grep -oP '(?<=wlan.fc.subtype": ")[^"]*')

    # Only write if at least one field is non-empty
    if [[ -n "$FRAME_TIME" || -n "$WLAN_FC_TYPE" || -n "$WLAN_FC_SUBTYPE" ]]; then
        [[ -n "$FRAME_TIME" ]] && echo "\"frame.time\": \"$FRAME_TIME\"," >> "$OUTPUT_FILE"
        [[ -n "$WLAN_FC_TYPE" ]] && echo "\"wlan.fc.type\": \"$WLAN_FC_TYPE\"," >> "$OUTPUT_FILE"
        [[ -n "$WLAN_FC_SUBTYPE" ]] && echo "\"wlan.fc.subtype\": \"$WLAN_FC_SUBTYPE\"," >> "$OUTPUT_FILE"
        echo >> "$OUTPUT_FILE"  # Add a newline for readability
    fi
done < "$INPUT_FILE"

echo "Extraction completed. Output saved in '$OUTPUT_FILE'."
