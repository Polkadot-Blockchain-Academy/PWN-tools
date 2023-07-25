#!/bin/bash
# #####################################################################
# Polkadot Blockchain Academy Proof-of-Winning tools
# Verify CSV file with signed messages and plain-text addresses
# 
# $ ./verify-winners-csv.sh some-input.csv > verified.csv 
# 
# Polkadot Blockchain Academy - UNLICENSE - 2023-02-01
# #####################################################################

i=0

while IFS=, read -r MESSAGE ADDRESS SIGNATURE
do
    echo -e "\n\n$MESSAGE $SIGNATURE $ADDRESS"
    subkey verify --message "$MESSAGE" "$SIGNATURE" "$ADDRESS"
done < $1