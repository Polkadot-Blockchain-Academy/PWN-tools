#!/bin/bash
# #####################################################################
# Polkadot Blockchain Academy Proof-of-Winning tools
# Hash a custom csv file with secrets to get sha512sum(secret)
# 
# $ ./hash-secrets-csv.sh some-input.csv > hashes.csv 
# 
# Polkadot Blockchain Academy - UNLICENSE - 2023-02-01
# #####################################################################


while IFS=, read -r a secret b c d e f g 
do
    printf "$secret" | sha512sum | awk '{print $1}'
done < $1