#!/bin/bash
# #####################################################################
# Polkadot Blockchain Academy Proof-of-Winning tools
# Verify a `PWN-<your address>.json` payload
# 
# Polkadot Blockchain Academy - UNLICENSE - 2023-02-01
# #####################################################################

## ONCE RESOLVED UPDATE TO MATCH UNIFORM BEHAVIOR
## https://github.com/polkadot-js/apps/issues/8930

# echo    " Dependencies:\n"
# echo    " - sha512sum (OS package manager): https://unix.stackexchange.com/questions/426837/no-sha256sum-in-macos"
# echo    " - subkey (cargo): https://github.com/paritytech/substrate/tree/master/bin/utils/subkey#install-with-cargo"
# echo    " - jq (OS package manager): https://stedolan.github.io/jq/\n"
# echo    " - xxd (OS package manager):https://unix.stackexchange.com/questions/1316/convert-ascii-code-to-hexadecimal-in-unix-shell-script_\n"

# Gather payloads, and run on a single file with this script command:

# Sign your provided message username (only)
# TODO this is correct once this lands: https://github.com/paritytech/substrate/pull/13258
# subkey verify --message "$(jq '.message' "$1" -rj)" "$(jq '.signature' "$1" -rj)" "$(jq '.ss58Address' "$1" -rj)"

# For now, it's broken enough to need to convert first...
MESSAGE=$(printf "$(jq '.message' "$1" -rj)")
# MESSAGE_HEX="0x$(echo $MESSAGE | xxd -ps -c 200)"
MESSAGE_HEX="$(echo $MESSAGE | xxd -ps -c 200)"
echo $MESSAGE_HEX
# cut the new line char at the end 🤦 bash needed
# MESSAGE_HEX=$(tr '0a' '' < $MESSAGE_HEX)
MESSAGE_HEX=${MESSAGE_HEX/0a}
echo $MESSAGE_HEX
# MESSAGE_HASH="0x$(printf "$SECRET" | sha512sum | awk '{print $1}')"
subkey verify --message $MESSAGE_HEX "$(jq '.signature' "$1" -rj)" "$(jq '.ss58Address' "$1" -rj)"

# debug, no HD path, most wallets:
# {
#   "message": "I LIKE WINNING! BOOOOO YAAAAAA!",
#   "ss58Address": "14XeJg226wvHG6PWmhKUsrv5PmeccjbXwFe9pVrBbryEWeZc",
#   "secretHash": "0x58cf16bcdceec9bce18246eeaa2f3358a2cdfdb7dc98a3d5f61da18f841b057369c58e64a456e236e853d853ef088a0eb57551a2a2b124c3060d5f402a2bf0a3",
#   "signature": "0x683dc112821364f6201f5e6c231a156ae8a4bc10a931972825543c6e8f273e47b271756d70366ba154fb29ea15360d3210f8e05951d64dd27518c8fd3476a587"
# } 
# Tested to verify correctly on https://polkadot.js.org/apps/#/signing/verify
# Also another good signature:
# "0x3ef12aa93dc7eca7d60616f9b2535f967c202ba77ca80451847d528025bde836280744bf9ca643413c93ce3702841414ef5b9ff4d0bb9c63f1b48dc0a2e6ff8e"