#!/bin/bash
######################################################################
# Polkadot Blockchain Academy Proof-of-Winning tools
# Generate `proof-of-winning.json` payload
#
# For Polkadot.js API and <Bytes /> wrapped messages
# 
# Polkadot Blockchain Academy - UNLICENSE - 2023-02-01
# #####################################################################

## TODO ONCE RESOLVED UPDATE TO MATCH UNIFORM BEHAVIOR:
## https://github.com/polkadot-js/apps/issues/8930

clear
echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo -e "                  Make sure to read and understand what this script does before you use it!"
echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
echo -e " Dependencies:\n"
echo -e " - sha512sum (OS package manager): https://unix.stackexchange.com/questions/426837/no-sha256sum-in-macos"
echo -e " - subkey (cargo): https://github.com/paritytech/substrate/tree/master/bin/utils/subkey#install-with-cargo"
echo -e " - jq (OS package manager): https://stedolan.github.io/jq/\n"

echo -en "                                     👌 Press [ENTER] to start..."
read -s START
clear

echo -e "//////////////////////////////////////////////////////////////////////////////////////////////////////////"
echo -e "////////////////           ///////////////////////////////////////////////////////////////////////////////"
echo -e "//////////////               /////////////////////////////////////////////////////////////////////////////"
echo -e "////////    ////           ////    ////////////////////////////////*  *///////////////////////////////////"
echo -e "/////        /////////////////        ////////////////////////////.   ,///////////////////////***/////////"
echo -e "////         /////////////////          /////////////////////////*    ///////////////////////.   ,////////"
echo -e "///         ////////////////////        /////////////////////////.   ,//////////////////////*.   /////////"
echo -e "///      /////////////////////////      //////////////*             .//////*.         .*//*           *///"
echo -e "////////////////////////////////////////////////////,.   .,,**,.    ,///*,    .,,,.    ***,.    ,,,,,*////"
echo -e "/////  ///////////////////////////////////////////*.   ,*//////,   ,*//*    *//////,   ,//*.   ,//////////"
echo -e "///       ///////////////////////       /////////*.   *///////,    *//*    *///////,   ,//*   .///////////"
echo -e "///         ///////////////////         ////////*     ///////,    .*//,   .///////,    */*.   ,/////**////"
echo -e "////         /////////////////         /////////*     ,///*,.     ,**,     *////*.   .///*.   ,//*.   ,///"
echo -e "//////       /////////////////       ////////////,.         ,,       .,.           ,*/////,         .*////"
echo -e "///////////////             ////////////////////////**,,,,,*///*,,,,*/////*,,,,**///////////*,,,,**///////"
echo -e "///////////////             //////////////////////////////////////////////////////////////////////////////"
echo -e "//////////////////       /////////////////////////////////////////////////////////////////////////////////"
echo -e "//////////////////////////////////////////////////////////////////////////////////////////////////////////"
echo -e ""
echo -e "==========================================================================================================\n"
echo -e "                           🎉🔐🔏 Blockchain Academy Proof-of-Win (PWN) 🔏🔐🎉\n"
echo -e "==========================================================================================================\n"
echo -e "                                         This script processes a:"
echo -e "                                            - ⚠PRIZE SECRET⚠"
echo -e "                                            - SIGNED MESSAGE"
echo -e "                              *without* writing them to disk or terminal history.\n"
echo -e "                               It outputs a \"PWN-<your address>.json\" to submit"
echo -e "                                      to the Academy team to verify 🕵️\n"
echo -e "                           Alternatively, you could subkey to sign, providing a secret"
echo -e "                            Use \"generate-proof-of-win-private-key.sh\" instead\n"

echo -e "  🕸️ The network for the SS58 address (polkadot, kusama, some parachain...): "
read NETWORK

# debug, uncomment to override:
# NETWORK="kusama"

echo -en "  🔏 Your need to sign a message out of band from this script.\nProvide a"
echo -e "  📝 A public, pseudononymous, message for the Academy class (any text, without \"quotes\"):\n"

read UNWRAPED_MESSAGE

# debug, uncomment to override:
# UNWRAPED_MESSAGE="I LIKE WINNING! BOOOOO YAAAAAA!"

echo -e "\n  👆 Copy&Paste into a PJ.js tool to sign (no padding, spaces, or new lines!)\n"
echo -e "               🔏 Open up a wallet using Polkadot.js API to sign, maybe via https://polkadot.js.org/apps/#/signing/ ..."
echo -e "                                     ⏳ Press [ENTER] after you have a signature..."
read CRAP

MESSAGE="<Bytes>$UNWRAPED_MESSAGE</Bytes>"
echo -e "  🤦 You message is opaquely wrapped by Polkadot.js (https://github.com/polkadot-js/apps/issues/8930) so the message you *actually* signed is:\n"
echo -e "$MESSAGE\n" 

echo -e  "  😅 But we can deal with that 👍 let's continue...\n"
echo -en "  🔏 Your SIGNATURE for the message (raw hex):"
read SIGNATURE

# debug, uncomment to override:
# seed used: subkey inspect "middle harsh axis absurd message meadow kick soccer empty left adult giraffe"
# SIGNATURE="0x78bea5e6ae9973c9842e33c1f37109fd5a8dc4f954cd22a133756a7590fffd0363f956afd24a16a6bcb00a3ce7bfdcc8045dad80b421bd01a8948ff9d2853e8a"


echo -e  "  🙋 Your PUBLIC KEY (ss58 address or raw hex) used to sign the above message..."
echo -en "  💸 THE PRIZE WILL BE SENT HERE (0x..... *or* 14VJA6...): "
read PUB

# debug, uncomment to override:
# seed used: subkey inspect "middle harsh axis absurd message meadow kick soccer empty left adult giraffe"
# PUB="14XeJg226wvHG6PWmhKUsrv5PmeccjbXwFe9pVrBbryEWeZc"

PUBKEY="$(subkey inspect "$PUB" --network "$NETWORK" --output-type json | jq '.publicKey' -rj)"
ADDRESS="$(subkey inspect "$PUB" --network "$NETWORK" --output-type json | jq '.ss58Address' -rj)"

echo -en "\n\n      🙋 Your Public Key (sr25519) = $PUBKEY"
echo -e "\n\n      🙋 Your Address (SS58) for $NETWORK = $ADDRESS"
echo -e "       👀 !!!!!!! BE SURE THESE ARE AS YOU EXPECT !!!!!!!\n\n"

echo -e "                 👌 Press [ENTER] to continue..."
read -s CONTINUE

echo -e "  🙈 Your  provided secret is hashed for you by the script, not exposed in the output.\n"
echo -e "  🏆 Your prize secret (three words, space separated): <hidden input>"
read -s SECRET

# debug, uncomment to override:
# SECRET="some thee words"

SECRET_HASH="0x$(printf "$SECRET" | sha512sum | awk '{print $1}')"

# DELETE SECRET
unset SECRET

ADDRESS="$(subkey inspect "$PUBKEY" --network "$NETWORK" --output-type json | jq '.ss58Address' -rj)"

echo -en "  🙋 Your Pub Key (SS58) for ""$NETWORK"" =""$ADDRESS"

FILE="PWN-""$ADDRESS"".json"

echo -e "\n\n                    👇 🔐 $FILE 🔐 👇"

# Write PWN-$ADDRESS.json
jq -n --arg message "$MESSAGE" --arg ss58Address "$ADDRESS" --arg secretHash "$SECRET_HASH" --arg signature "$SIGNATURE" '.message = $message | .ss58Address = $ss58Address | .secretHash = $secretHash | .signature = $signature' > $FILE

jq < $FILE

echo -e "                   📬 Deliver $FILE 📬"
echo -e "                   The Academy team will provide a link to upload or paste this json into.\n"
echo -en "                                 🗑 Press [ENTER] to clear the screen..."
read -s LESS
clear
echo -en "\n\n\n\n                                        Less Trust.\n"
read -s MORE
echo -e          "                                        More Truth.\n\n\n\n"
read -s MIC_DROP

# debug, no HD path, most wallets:
# {
#   "message": "<Bytes>I LIKE WINNING! BOOOOO YAAAAAA!</Bytes>",
#   "ss58Address": "14XeJg226wvHG6PWmhKUsrv5PmeccjbXwFe9pVrBbryEWeZc",
#   "secretHash": "0x58cf16bcdceec9bce18246eeaa2f3358a2cdfdb7dc98a3d5f61da18f841b057369c58e64a456e236e853d853ef088a0eb57551a2a2b124c3060d5f402a2bf0a3",
#   "signature": "0x78bea5e6ae9973c9842e33c1f37109fd5a8dc4f954cd22a133756a7590fffd0363f956afd24a16a6bcb00a3ce7bfdcc8045dad80b421bd01a8948ff9d2853e8a"
# }
# Tested to verify correctly using the UNWRAPPED message "I LIKE WINNING! BOOOOO YAAAAAA!" on https://polkadot.js.org/apps/#/signing/verify
