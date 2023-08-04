#!/bin/bash
# #####################################################################
# Polkadot Blockchain Academy Proof-of-Winning tools
# Verify a CSV file with a single PWN JSON opject per new line.
#
# Example line of expected csv:
# { "message": "<Bytes>I LIKE WINNING! BOOOOO YAAAAAA!</Bytes>", "ss58Address": "14XeJg226wvHG6PWmhKUsrv5PmeccjbXwFe9pVrBbryEWeZc", "signature": "0x78bea5e6ae9973c9842e33c1f37109fd5a8dc4f954cd22a133756a7590fffd0363f956afd24a16a6bcb00a3ce7bfdcc8045dad80b421bd01a8948ff9d2853e8a"}
# (file must end with empty new line)
#
# Run this to output to a results.csv file:
# $ ./verify-winners-csv.sh one-PWN-json-per-new-line.csv 2>&1 | tee results.csv
# 
# Polkadot Blockchain Academy - UNLICENSE - 2023-02-01
# #####################################################################

i=0

while read -r line; do
    MESSAGE=$(echo $line | jq -rj '.message')
    SIGNATURE=$(echo $line | jq -rj '.signature')
    ADDRESS=$(echo $line | jq -rj '.ss58Address')
    # # Debug, comment out to write to results.csv:
    # echo "=============="
    # echo -e "$MESSAGE $SIGNATURE $ADDRESS"
    # i=$(($i+1))
    # echo -n "line $i:   "
    echo -n "$ADDRESS, "
    subkey verify --message "$MESSAGE" "$SIGNATURE" "$ADDRESS"
done < $1